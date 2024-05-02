-- TS and JS LSP configuration
require'lspconfig'.tsserver.setup{
  on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
  end,
  flags = {
    debounce_text_changes = 150,
  }
}

-- C Sharp, maybe. Not sure if this one works
require'lspconfig'.omnisharp.setup{
    cmd = { "/home/narian/.local/bin/omnisharp/run", "--languageserver" , "--hostPID", tostring(pid) },
}

-- C and C++
require'lspconfig'.clangd.setup{}

-- Python
local nvim_lsp = require('lspconfig')
nvim_lsp.pyright.setup{
    on_attach = function(client, bufnr)
        require('cmp').setup.buffer { enabled = true }
        local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
        local opts = { noremap=true, silent=true }
        -- Mapping shortcuts here
    end,
    settings = {
        python = {
            analysis = {
                typeCheckingMode = "basic"
            }
        }
    }
}
