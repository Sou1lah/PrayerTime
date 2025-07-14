local M = {}

M.prayers = {
	{ name = "Fajr",    time = "04:15" },
	{ name = "Dhuhr",   time = "13:00" },
	{ name = "Asr",     time = "16:30" },
	{ name = "Maghrib", time = "19:45" },
	{ name = "Isha",    time = "21:00" },
}

local function format_time(seconds)
	local abs = math.abs(seconds)
	local hours = math.floor(abs / 3600)
	local minutes = math.floor((abs % 3600) / 60)
	local secs = abs % 60
	return string.format("%02d:%02d:%02d", hours, minutes, secs)
end

function M.get_time_left(prayer_time)
	local now = os.date("*t")
	local h, m = prayer_time:match("(%d+):(%d+)")
	local target = os.time({
		hour = tonumber(h),
		min = tonumber(m),
		sec = 0,
		day = now.day,
		month = now.month,
		year = now.year,
	})

	local diff = os.difftime(target, os.time())

	local status
	if diff > 0 then
		status = "Upcoming"
	elseif math.abs(diff) < 600 then
		status = "Now"
	else
		status = "Missed"
	end

	return diff, format_time(diff), status
end

return M
