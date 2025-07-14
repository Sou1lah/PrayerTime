local data = require("prayertime.data")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values

local M = {}

function M.open()
	local results = {}

	for _, p in ipairs(data.prayers) do
		local _, left, status = data.get_time_left(p.time)
		table.insert(results, {
			value = p,
			display = string.format("%-8s | %s | %s", p.name, left, status),
			ordinal = p.name,
		})
	end

	pickers.new({}, {
		prompt_title = "Prayer Times",
		finder = finders.new_table {
			results = results,
			entry_maker = function(entry)
				return {
					value = entry.value,
					display = entry.display,
					ordinal = entry.ordinal,
				}
			end
		},
		sorter = conf.generic_sorter({}),
	}):find()
end

return M
