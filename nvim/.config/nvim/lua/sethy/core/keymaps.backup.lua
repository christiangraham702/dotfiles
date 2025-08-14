local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "moves lines down in visual selection" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "moves lines up in visual selection" })

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "move down in buffer with cursor centered" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "move up in buffer with cursor centered" })
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- the how it be paste
vim.keymap.set("x", "<leader>p", [["_dP]])

-- remember yanked
vim.keymap.set("v", "p", '"_dp', opts)

-- Copies or Yank to system clipboard
vim.keymap.set("n", "<leader>Y", [["+Y]], opts)

-- leader d delete wont remember as yanked/clipboard when delete pasting
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- ctrl c as escape cuz Im lazy to reach up to the esc key
vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "<C-c>", ":nohl<CR>", { desc = "Clear search hl", silent = true })
-- format without prettier using the built in
-- was: vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, { desc = "Format (LSP)" })
-- Unmaps Q in normal mode
vim.keymap.set("n", "Q", "<nop>")

--Stars new tmux session from in here
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- prevent x delete from registering when next paste
vim.keymap.set("n", "x", '"_x', opts)

-- Replace the word cursor is on globally
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "Replace word cursor is on globally" })

-- Executes shell command from in here making file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "makes file executable" })

-- Hightlight yanking
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})

-- tab stuff
vim.keymap.set("n", "<leader>to", "<cmd>tabnew<CR>")   --open new tab
vim.keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>") --close current tab
vim.keymap.set("n", "<leader>tn", "<cmd>tabn<CR>")     --go to next
vim.keymap.set("n", "<leader>tp", "<cmd>tabp<CR>")     --go to pre
vim.keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>") --open current tab in new tab

--split management
vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
-- split window vertically
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
-- split window horizontally
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
-- close current split window
vim.keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- Copy filepath to the clipboard
vim.keymap.set("n", "<leader>fp", function()
  local filePath = vim.fn.expand("%:~") -- Gets the file path relative to the home directory
  vim.fn.setreg("+", filePath) -- Copy the file path to the clipboard register
  print("File path copied to clipboard: " .. filePath) -- Optional: print message to confirm
end, { desc = "Copy file path to clipboard" })

-- Toggle LSP diagnostics visibility
local isLspDiagnosticsVisible = true
vim.keymap.set("n", "<leader>lx", function()
    isLspDiagnosticsVisible = not isLspDiagnosticsVisible
    vim.diagnostic.config({
        virtual_text = isLspDiagnosticsVisible,
        underline = isLspDiagnosticsVisible
    })
end, { desc = "Toggle LSP diagnostics" })


-- Which-key groups + LazyVim-like find/search menu
local ok, wk = pcall(require, "which-key")
if ok then
  wk.add({
    -- top-level groups (these make the pretty menu headers)
    { "<leader>b", group = "+buffer" },
    { "<leader>c", group = "+code" },         -- you just added <leader>cf here
    { "<leader>d", group = "+diagnostics/quickfix" },
    { "<leader>f", group = "+file/find" },    -- <-- bring back the find group
    { "<leader>g", group = "+git" },
    { "<leader>q", group = "+quit/session" },
    { "<leader>s", group = "+search" },
    { "<leader>t", group = "+tabs" },
    { "<leader>u", group = "+ui" },
    { "<leader>w", group = "+windows" },

    -- find/search (adjust to your plugins)
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files (Root Dir)" },
    { "<leader>fF", "<cmd>Telescope find_files hidden=true no_ignore=true<cr>", desc = "Find Files (All)" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Grep (Root Dir)" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },

    -- search
    { "<leader>ss", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols" },
    { "<leader>sS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace Symbols" },
    { "<leader>sr", "<cmd>Telescope resume<cr>", desc = "Resume Last Picker" },

    -- buffer
    { "<leader>bd", "<cmd>bd<cr>", desc = "Delete Buffer" },
    { "<leader>bo", "<cmd>%bd|e#|bd#<cr>", desc = "Only Buffer" },

    -- git (if gitsigns / telescope git pickers available)
    { "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "Status" },
    { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Commits" },
    { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Branches" },

    -- windows (you already have split maps; this just lists them nicely)
    { "<leader>wv", "<C-w>v", desc = "Split Vertical" },
    { "<leader>wh", "<C-w>s", desc = "Split Horizontal" },
    { "<leader>we", "<C-w>=", desc = "Equalize" },
    { "<leader>wx", "<cmd>close<cr>", desc = "Close Split" },

    -- quit/session
    { "<leader>qq", "<cmd>qa<cr>", desc = "Quit All" },
    { "<leader>qS", "<cmd>mksession! ~/.config/nvim/Session.vim<cr>", desc = "Save Session" },
    { "<leader>qs", "<cmd>source ~/.config/nvim/Session.vim<cr>", desc = "Load Session" },
  })
end 
