local bufnr = vim.api.nvim_get_current_buf()
vim.keymap.set("n", "<leader>ca", function()
    vim.cmd.RustLsp("codeAction") -- supports rust-analyzer's grouping
    -- or vim.lsp.buf.codeAction() if you don't want grouping.
end, { silent = true, buffer = bufnr })
vim.keymap.set("n", "K", function()
    vim.cmd.RustLsp({ "hover", "actions" })
end, { silent = true, buffer = bufnr })
vim.keymap.set("n", "<leader>ld", function()
    vim.cmd.RustLsp({ "renderDiagnostic", "current" })
end, { silent = true, buffer = bufnr })
vim.keymap.set("n", "<leader>cd", function()
    vim.cmd.RustLsp({ "renderDiagnostic", "cycle" })
end, { silent = true, buffer = bufnr })
