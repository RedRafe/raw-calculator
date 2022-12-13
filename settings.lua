-- Settings
local CONFIG = require("__technology-overload__/" .. "config")

data:extend({
	-- Level difficulty
	{
		type = "string-setting",
		name = "to-difficulty",
		setting_type = "startup",
		default_value = "Fibonacci",
		allowed_values = CONFIG.difficulty,
		order = "to-100"
	},
  {
		type = "int-setting",
		name = "to-tree-coefficient",
		setting_type = "startup",
		default_value = CONFIG.Tree.coefficient,
		minimum_value = CONFIG.Tree.min,
    maximum_value = CONFIG.Tree.max,
		order = "to-200"
	},
	{
		type = "int-setting",
		name = "to-ms-coefficient",
		setting_type = "startup",
		default_value = CONFIG.MS.coefficient,
		minimum_value = CONFIG.MS.min,
    maximum_value = CONFIG.MS.max,
		order = "to-150"
	},
})