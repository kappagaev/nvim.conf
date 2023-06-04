vim.keymap.set("n", "<leader>g", function()
    if vim.bo.ft ~= "fugitive" then
      vim.cmd.Git()
      vim.cmd("wincmd o")
    else
      vim.cmd("bd")
  end
end, {silent = true})

local ThePrimeagen_Fugitive = vim.api.nvim_create_augroup("ThePrimeagen_Fugitive", {})

local autocmd = vim.api.nvim_create_autocmd
autocmd("BufWinEnter", {
    group = ThePrimeagen_Fugitive,
    pattern = "*",
    callback = function()
        if vim.bo.ft ~= "fugitive" then
            return
        end

        local bufnr = vim.api.nvim_get_current_buf()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.winbar = "     "
        local opts = {buffer = bufnr, remap = false}
        vim.keymap.set("n", "<leader>P", function()
            vim.cmd.Git('push')
        end, opts)

        -- rebase always
        vim.keymap.set("n", "<leader>p", function()
            vim.cmd.Git({'pull',  '--rebase'})
        end, opts)

        vim.keymap.set("n", "<leader>t", ":Git push -u origin ", opts);
    end,
})

vim.keymap.set("n", "gd", vim.cmd.Gdiffsplit)
vim.keymap.set("n", "gD", ":Gdiffsplit!<CR>", { silent = true })

