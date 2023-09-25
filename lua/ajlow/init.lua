--Remap space as leader key
vim.keymap.set("", "<Space>", "<Nop>", { desc = "Nop on space since I use it as leader"})
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("ajlow.std.options")
require("ajlow.std.autocommands")
require("ajlow.lazy")
require("ajlow.std.keymaps")

-- TODO: Debugging
-- TODO: Encryption

-- TODO: https://github.com/rmagatti/auto-session
