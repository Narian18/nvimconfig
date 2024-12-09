-- TS and JS LSP configuration
require'lspconfig'.tl_ls.setup{
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
local function get_python_path(workspace)
  -- Find and return the Python path for the virtual environment
  local venv_path_1 = workspace .. '/.venv/bin/python'
  local venv_path_2 = workspace .. '/venv/bin/python'
  if vim.fn.executable(venv_path_1) == 1 then
    return venv_path_1
  elseif vim.fn.executable(venv_path_2) == 1 then
      return venv_path_2
  else
    return vim.fn.exepath('python3') -- Fallback to system Python
  end
end

local nvim_lsp = require('lspconfig')
nvim_lsp.pyright.setup{
    before_init = function(_, config)
        config.settings.python.pythonPath = get_python_path(vim.fn.getcwd())
    end,
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

-- Go LSP
require'lspconfig'.gopls.setup{
    on_attach = function(client, bufnr)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<A-CR>', '', {
            noremap = true,
            silent = true, 
            callback = function()
                vim.lsp.buf.code_action({
                    context = { only =  { "source.organizeImports" } },
                    apply = true
                })
            end,
        })

        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-A-L>', '', {
            noremap = true,
            silent = true, 
            callback = function()
                vim.lsp.buf.format({
                    async = true
                })
            end,
        })
    end,
    settings = {
        gopls = {
            staticcheck = true,
        }
    }
}
