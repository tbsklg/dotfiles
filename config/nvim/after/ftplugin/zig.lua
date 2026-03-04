local bufnr = vim.api.nvim_get_current_buf()
local opts = { silent = true, buffer = bufnr }

local function run_in_terminal(cmd)
    vim.cmd("botright split | terminal " .. cmd)
    vim.cmd("startinsert")
end

local function run_in_quickfix(cmd)
    vim.fn.setqflist({})
    vim.cmd("cclose")
    local output = {}
    vim.fn.jobstart(cmd, {
        stdout_buffered = true,
        stderr_buffered = true,
        on_stderr = function(_, data)
            if data then
                vim.list_extend(output, data)
            end
        end,
        on_exit = function()
            local items = {}
            for _, line in ipairs(output) do
                if line ~= "" then
                    table.insert(items, { text = line })
                end
            end
            vim.fn.setqflist(items, "r")
            if #items > 0 then
                vim.cmd("copen")
            else
                vim.notify("zig build: OK", vim.log.levels.INFO)
            end
        end,
    })
end

-- zig build → quickfix (jump to errors)
vim.keymap.set("n", "<leader>zb", function()
    run_in_quickfix("zig build 2>&1")
end, vim.tbl_extend("force", opts, { desc = "Zig build (quickfix)" }))

-- zig run → terminal split
vim.keymap.set("n", "<leader>zr", function()
    run_in_terminal("zig run " .. vim.fn.expand("%"))
end, vim.tbl_extend("force", opts, { desc = "Zig run current file" }))

-- zig test → terminal split
vim.keymap.set("n", "<leader>zt", function()
    run_in_terminal("zig test " .. vim.fn.expand("%"))
end, vim.tbl_extend("force", opts, { desc = "Zig test current file" }))
