-- Settings
local CONFIG = require("__technology-overload__/" .. "config")
local DEFAULT = CONFIG.presets.None
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
		type = "bool-setting",
		name = "to-allowCustomization",
		setting_type = "startup",
		default_value = DEFAULT.allowCustomization,
		order = "to-200"
	},
	{
		type = "bool-setting",
		name = "to-searchDept",
		setting_type = "startup",
		default_value = DEFAULT.searchDept,
		order = "to-300"
	},
	{
		type = "bool-setting",
		name = "to-applyDepth",
		setting_type = "startup",
		default_value = DEFAULT.applyDepth,
		order = "to-400"
	},
	{
		type = "double-setting",
		name = "to-treeCoefficient",
		setting_type = "startup",
		default_value = DEFAULT.treeCoefficient,
		minimum_value = 1 / 100000,
    maximum_value = 100000,
		order = "to-500"
	},
	{
		type = "double-setting",
		name = "to-depthExp",
		setting_type = "startup",
		default_value = DEFAULT.depthExp,
		minimum_value = 1 / 1000,
    maximum_value = 1000,
		order = "to-600"
	},
	{
		type = "bool-setting",
		name = "to-inverseDepth",
		setting_type = "startup",
		default_value = DEFAULT.inverseDepth,
		order = "to-700"
	},
	

})