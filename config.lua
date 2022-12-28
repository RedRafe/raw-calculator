local CONFIG = {}

local difficulty =
{
  "None",
  "Funnel",
  "Miserable Spoon",
  "Fibonacci",
  "Spiral",
  "Mad Spiral",
  "Tree",
  "Mad Tree",
  "A Long Way Home"
}

local presets = {
  ["None"]            = { searchDept = false, treeCoefficient = 1, applyDepth = false, depthExp = 1, inverseDepth = false, allowCustomization = false },
  ["Funnel"]          = { searchDept = false, treeCoefficient = 1, applyDepth =  true, depthExp = 1, inverseDepth =  true },
  ["Miserable Spoon"] = { searchDept = false, treeCoefficient = 2, applyDepth =  true, depthExp = 2, inverseDepth =  true },
  ["Fibonacci"]       = { searchDept = false, treeCoefficient = 1, applyDepth = false, depthExp = 1, inverseDepth = false },
  ["Spiral"]          = { searchDept = false, treeCoefficient = 1, applyDepth =  true, depthExp = 1, inverseDepth = false },
  ["Mad Spiral"]      = { searchDept =  true, treeCoefficient = 1, applyDepth =  true, depthExp = 1, inverseDepth = false },
  ["Tree"]            = { searchDept = false, treeCoefficient = 2, applyDepth =  true, depthExp = 1, inverseDepth = false },
  ["Mad Tree"]        = { searchDept =  true, treeCoefficient = 2, applyDepth =  true, depthExp = 1, inverseDepth = false },
  ["A Long Way Home"] = { searchDept = false, treeCoefficient = 1, applyDepth =  true, depthExp = 2, inverseDepth = false },
  --["Custom Exponential"] = { searchDept = false, treeCoefficient = 1, applyDepth = false, depthExp = 1, inverseDepth = false },
  --["Custom Fibonacci"] = { searchDept = false, treeCoefficient = 1, applyDepth = false, depthExp = 1, inverseDepth = false },
}
---------------------------------------------------------------------------
CONFIG.difficulty = difficulty
CONFIG.presets = presets

return CONFIG