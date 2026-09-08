return {
  on_init = function(client, _)
    -- Track retries per request id so one slow request can't exhaust a shared
    -- counter and permanently break subsequent requests (as the nvim-lspconfig
    -- built-in handler does).
    local retries = {}

    local function typescriptHandler(_, result, context)
      local ts_client = vim.lsp.get_clients({ bufnr = context.bufnr, name = 'vtsls' })[1]
        or vim.lsp.get_clients({ bufnr = context.bufnr, name = 'ts_ls' })[1]
        or vim.lsp.get_clients({ bufnr = context.bufnr, name = 'typescript-tools' })[1]

      if not ts_client then
        -- `vtsls` can take a few seconds to attach on first open (it has to load
        -- the @vue/typescript-plugin), so retry for a while before giving up.
        -- The notification params arrive wrapped, e.g. `{ { id, cmd, args } }`.
        local param = type(result) == 'table' and result[1] or nil
        local id = type(param) == 'table' and param[1] or nil

        if type(id) == 'number' and (retries[id] or 0) < 50 then -- ~5 seconds
          retries[id] = (retries[id] or 0) + 1
          vim.defer_fn(function()
            typescriptHandler(_, result, context)
          end, 100)
        else
          if type(id) == 'number' then
            retries[id] = nil
          end
          vim.notify(
            'Could not find `vtsls`, `ts_ls`, or `typescript-tools` lsp client required by `vue_ls`.',
            vim.log.levels.ERROR
          )
        end
        return
      end

      -- vscode-jsonrpc wraps the params vue_ls sends, so the notification
      -- arrives as `{ { requestId, command, args } }` (not a flat array).
      local param = unpack(result)
      local id, command, payload = unpack(param)
      retries[id] = nil

      ts_client:exec_cmd({
        title = 'vue_request_forward', -- You can give title anything as it's used to represent a command in the UI, `:h Client:exec_cmd`
        command = 'typescript.tsserverRequest',
        arguments = {
          command,
          payload,
        },
      }, { bufnr = context.bufnr }, function(_, r)
        local response = r and r.body
        -- TODO: handle error or response nil here, e.g. logging
        -- NOTE: Do NOT return if there's an error or no response, just return nil back to the vue_ls to prevent memory leak
        local response_data = { { id, response } }

        ---@diagnostic disable-next-line: param-type-mismatch
        client:notify('tsserver/response', response_data)
      end)
    end

    client.handlers['tsserver/request'] = typescriptHandler
  end,
}