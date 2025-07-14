local M = {}

local data = require("prayertime.data")
local notify = require("prayertime.notify")

function M.setup()
	vim.api.nvim_create_user_command("PrayerTime", function()
		require("prayertime.telescope").open()
	end, {})

	-- Check every 1 minute
	vim.fn.timer_start(60 * 1000, function()
		notify.check_and_notify()
	end, { ["repeat"] = -1 })
end

return M
