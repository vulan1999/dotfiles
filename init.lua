if vim.loader then
	vim.loader.enable()
end

require("config.keymaps")
require("config.options")
require("plugins")
require("utils")
