local M = {}
local data = require("prayertime.data")

function M.check_and_notify()
	for _, p in ipairs(data.prayers) do
		local diff, _ = data.get_time_left(p.time)
		if diff <= 600 and diff > 0 then -- 10 mins
			vim.schedule(function()
				vim.notify("⏰ " .. p.name .. " in " .. math.floor(diff / 60) .. " minutes", vim.log.levels.INFO)
			end)
		end
	end
end

return M
