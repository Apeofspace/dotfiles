local M = {}

function M.merge_keys(config, new_keys)
	config.keys = config.keys or {}
	local existing_keys = config.keys
	for _, keymap in ipairs(new_keys) do
		table.insert(existing_keys, keymap)
	end
end

return M
