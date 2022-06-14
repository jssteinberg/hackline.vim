local M = {}

M.servers = function()
	local msg = ''
	local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
	local clients = vim.lsp.get_active_clients()
	local connected = {}

	if next(clients) == nil then
		return msg
	end

	for _, client in ipairs(clients) do
		local filetypes = client.config.filetypes

		if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
			table.insert(connected, client.name)
		end
	end

	return table.concat(connected, ',')
end

return M
