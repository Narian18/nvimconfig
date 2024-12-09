-- Packer bootstrap and initialization
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
  vim.api.nvim_command('packadd packer.nvim')
end

require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Plugins
    use 'preservim/nerdtree'
    use 'neovim/nvim-lspconfig' -- LSP configurations
    use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
    use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
    use 'hrsh7th/cmp-buffer' -- Buffer completions
    use 'hrsh7th/cmp-path' -- Path completions
    use 'hrsh7th/cmp-cmdline' -- Cmdline completions
    use 'saadparwaiz1/cmp_luasnip' -- Snippet completions
    use 'L3MON4D3/LuaSnip' -- Snippet engine
    use 'hrsh7th/cmp-nvim-lua' -- Neovim Lua API completions
    use 'folke/tokyonight.nvim'
    use 'nvim-treesitter/playground'
    use 'theprimeagen/harpoon'
    use ({
        'nvim-telescope/telescope.nvim', tag = '0.1.6',
        requires = { {'nvim-lua/plenary.nvim'} }
    })
    use ({
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    })
    use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
end)
