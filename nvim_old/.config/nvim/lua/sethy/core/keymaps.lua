-- ~/.config/nvim/lua/config/keymaps.lua
-- Minimal, LazyVim-style which-key groups + common actions

-- Leaders
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

-- Basic QoL
map("n", "<C-d>", "<C-d>zz", { desc = "Half-page down (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half-page up (centered)" })
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Windows / Splits
map("n", "<leader>wv", "<C-w>v", { desc = "Split Vertical" })
map("n", "<leader>wh", "<C-w>s", { desc = "Split Horizontal" })
map("n", "<leader>we", "<C-w>=", { desc = "Equalize" })
map("n", "<leader>wx", "<cmd>close<cr>", { desc = "Close Split" })

-- Tabs
map("n", "<leader>to", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader>tx", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader>tn", "<cmd>tabn<cr>", { desc = "Next Tab" })
map("n", "<leader>tp", "<cmd>tabp<cr>", { desc = "Prev Tab" })
map("n", "<leader>tf", "<cmd>tabnew %<cr>", { desc = "Tab this file" })

-- LSP: put format on <leader>cf so <leader>f can be a group
map("n", "<leader>cf", function() vim.lsp.buf.format() end, { desc = "Format (LSP)" })

-- Telescope “find/search” (requires telescope.nvim)
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files (Root Dir)" })
map("n", "<leader>fF", "<cmd>Telescope find_files hidden=true no_ignore=true<cr>", { desc = "Find Files (All)" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Grep (Root Dir)" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })
map("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Recent Files" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help Tags" })

-- Git (works great with telescope + gitsigns)
map("n", "<leader>gs", "<cmd>Telescope git_status<cr>", { desc = "Git Status" })
map("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", { desc = "Git Commits" })
map("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", { desc = "Git Branches" })

-- Buffer helpers
map("n", "<leader>bd", "<cmd>bd<cr>", { desc = "Delete Buffer" })
map("n", "<leader>bo", "<cmd>%bd|e#|bd#<cr>", { desc = "Only Buffer" })

-- Session / quit
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })

-- Which-key group headers (this makes the pretty menu)
local ok, wk = pcall(require, "which-key")
if ok then
  wk.add({
    { "<leader>b", group = "+buffer" },
    { "<leader>c", group = "+code" },
    { "<leader>d", group = "+diagnostics/quickfix" },
    { "<leader>f", group = "+file/find" },
    { "<leader>g", group = "+git" },
    { "<leader>q", group = "+quit/session" },
    { "<leader>s", group = "+search" },
    { "<leader>t", group = "+tabs" },
    { "<leader>u", group = "+ui" },
    { "<leader>w", group = "+windows" },
  })
end
