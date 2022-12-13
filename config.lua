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

local Tree = {}
Tree.coefficient = 2
Tree.max = 100000
Tree.min = 1

local MS = {}
MS.coefficient = 10
MS.max = 100000
MS.min = 1
---------------------------------------------------------------------------
CONFIG.difficulty = difficulty
CONFIG.Tree = Tree
CONFIG.MS = MS

return CONFIG