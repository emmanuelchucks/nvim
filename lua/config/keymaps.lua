-- keymaps.lua
--

-- Keymaps for better default experience
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Open floating diagnostic message
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })

-- Open Lazy
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Open lazy" })

-- Open Mason
vim.keymap.set("n", "<leader>m", "<cmd>Mason<cr>", { desc = "Open mason" })

return {}
