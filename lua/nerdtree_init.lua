vim.api.nvim_create_autocmd("StdinReadPre", {
    pattern = "*",
    callback = function()
        vim.g.std_in = 1
    end,
})

vim.api.nvim_create_autocmd("VimEnter", {
    pattern = "*",
    callback = function()
        if vim.fn.argc() == 0 and vim.fn.exists("g:std_in") == 0 then
            vim.cmd "NERDTree"
        end
    end,
})
