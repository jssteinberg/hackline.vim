local M = {}

local length = function(T)
	local count = 0
	for _ in pairs(T) do count = count + 1 end
	return count
end

M.get_connected_client_names = function()
	local connected_clients = {}
	local clients = vim.lsp.get_active_clients()
	local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")

	for _, client in pairs(clients) do
		local filetypes = client.config.filetypes

		if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
			table.insert(connected_clients, client.name)
		end
	end

	return connected_clients
end

M.names_connected = function(sep)
	sep = sep or " "
	local connected = M.get_connected_client_names()

	return table.concat(connected, sep)
end

M.length_connected = function()
	local connected = M.get_connected_client_names()

	return length(connected)
end

return M
