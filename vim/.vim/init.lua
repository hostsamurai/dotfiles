-- ----------------------------------------------------------------------
--
-- (魔境 makyō) - a Zen term meaning "ghost cave" or "devil's cave", a
-- perfect description of Vim configuration
--
-- ----------------------------------------------------------------------

local aniseed_env_path = vim.fn.stdpath("data") .. "/lazy/aniseed"
vim.opt.rtp:prepend(aniseed_env_path)

require('aniseed.env').init()
