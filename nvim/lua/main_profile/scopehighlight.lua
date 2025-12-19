local ns = vim.api.nvim_create_namespace("schl")
local prev_node = nil
local M = {}

local function get_first_word_on_line()
	local row = vim.api.nvim_win_get_cursor(0)[1] - 1 -- get current line (0-based)
	local line = vim.api.nvim_buf_get_lines(0, row, row + 1, false)[1] -- get the line text

	if not line then
		return nil
	end

	local col = line:find("%s") -- find first non-whitespace character
	if col then
		return row, col - 1 -- convert 1-based index to 0-based for neovim api
	else
		return nil, nil
	end
end

local function get_highest_node_on_line()
	local row, col = get_first_word_on_line()
	if not (row and col) then
		return nil
	end
	local node = vim.treesitter.get_node({ pos = { row, col }, ignore_injections = false })
	if not node then
		return nil
	end
	local anc = node:parent()
	while anc do
		if anc:range() == node:range() then
			node = anc
			anc = node:parent()
		else
			anc = nil
		end
	end
	return node
end

local function get_ancestor(node)
	if node then
		local anc = node:parent()
		if anc then
			if anc:parent() ~= nil then
				-- little crutch to ensure i dont return root
				node = anc
			end
		end
	end
	return node
end

function M.highlight_current_scope()
	local hl_group = "CursorLine"

	local node = get_highest_node_on_line()
	node = get_ancestor(node)

	if node ~= prev_node then
		vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
		prev_node = node
		if node ~= nil then
			local start_row, start_col, end_row, end_col = node:range()
			print(
				"start_row "
					.. start_row
					.. " end_row "
					.. end_row
					.. " start_col "
					.. start_col
					.. " end_col "
					.. end_col
			)

			-- add new highlight
			for row = start_row, end_row do
				vim.api.nvim_buf_add_highlight(0, ns, hl_group, row, 0, -1)
			end
		end
	end
end

-- Create the user command
vim.api.nvim_create_user_command("HlThis", M.highlight_current_scope, {})
-- Create decoration
vim.api.nvim_set_decoration_provider(ns, { on_win = M.highlight_current_scope })

-- There is some changes I want to make:
-- 1) I want it to understand blank lines inside scope
-- 2) I want it to show scope inside statements and functions and classes but not smaller scopes
-- 3) I want it to NOT show for inactive windows

return M
