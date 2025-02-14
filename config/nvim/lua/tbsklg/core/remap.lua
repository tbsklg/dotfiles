vim.g.mapleader = " "

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "Join line below" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Move to next search match" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Move to previous search match" })

vim.keymap.set(
    { "n", "v" },
    "<leader>d",
    [["_d]],
    { desc = "Delete to black hole register" }
)

vim.keymap.set("i", "<C-c>", "<Esc>", { desc = "Exit insert mode" })

vim.keymap.set("n", "Q", "<nop>", { desc = "Disable Ex mode" })
vim.keymap.set(
    "n",
    "<C-f>",
    "<cmd>silent !tmux neww tmux-sessionizer<CR>",
    { desc = "Open tmux sessionizer" }
)
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format" })

vim.keymap.set(
    "n",
    "<leader>fml",
    "<cmd>CellularAutomaton make_it_rain<CR>",
    { desc = "Make it rain" }
)

vim.keymap.set(
    "n",
    "<leader>gol",
    "<cmd>CellularAutomaton game_of_life<CR>",
    { desc = "Make it rain" }
)

-- window management
vim.keymap.set(
    "n",
    "<leader>sv",
    "<C-w>v",
    { desc = "Split window vertically" }
)
vim.keymap.set(
    "n",
    "<leader>sh",
    "<C-w>s",
    { desc = "Split window horizontally" }
)
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Equalize window sizes" })
vim.keymap.set("n", "<leader>sx", ":close<CR>", { desc = "Close window" })

vim.keymap.set("n", "<leader>to", ":tabnew<CR>", { desc = "Open new tab" })
vim.keymap.set("n", "<leader>tx", ":tabclose<CR>", { desc = "Close tab" })
vim.keymap.set("n", "<leader>tn", ":tabn<CR>", { desc = "Next tab" })
vim.keymap.set("n", "<leader>tp", ":tabp<CR>", { desc = "Previous tab" })

-- nvim-tree
vim.keymap.set(
    "n",
    "<leader>e",
    ":NvimTreeToggle<CR>",
    { desc = "Toggle nvim-tree" }
)
vim.keymap.set("n", "<leader>fr", ":NvimTreeFindFile<CR>", {})

-- telescope
vim.keymap.set(
    "n",
    "<leader>ff",
    "<cmd>Telescope find_files<cr>",
    { desc = "Find files" }
)
vim.keymap.set(
    "n",
    "<leader>fs",
    "<cmd>Telescope live_grep<cr>",
    { desc = "Find string" }
)
vim.keymap.set(
    "n",
    "<leader>fc",
    "<cmd>Telescope grep_string<cr>",
    { desc = "Find string under cursor" }
)
vim.keymap.set(
    "n",
    "<leader>fb",
    "<cmd>Telescope buffers<cr>",
    { desc = "Find buffers" }
)
vim.keymap.set(
    "n",
    "<leader>fh",
    "<cmd>Telescope help_tags<cr>",
    { desc = "Find help tags" }
)

-- telescope git commands
vim.keymap.set(
    "n",
    "<leader>gc",
    "<cmd>Telescope git_commits<cr>",
    { desc = "Find git commits" }
)
vim.keymap.set(
    "n",
    "<leader>gfc",
    "<cmd>Telescope git_bcommits<cr>",
    { desc = "Find git commits for buffer" }
)
vim.keymap.set(
    "n",
    "<leader>gb",
    "<cmd>Telescope git_branches<cr>",
    { desc = "Find git branches" }
)
vim.keymap.set(
    "n",
    "<leader>gs",
    "<cmd>Telescope git_status<cr>",
    { desc = "Find git status" }
)

vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", { desc = "Restart LSP" })

-- undotree
vim.keymap.set(
    "n",
    "<leader>u",
    vim.cmd.UndotreeToggle,
    { desc = "Toggle undotree" }
)

vim.keymap.set(
    "n",
    "<leader>z",
    "<cmd>ZenMode<cr>",
    { desc = "Toggle zen mode" }
)
