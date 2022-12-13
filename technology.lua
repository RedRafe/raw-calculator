if not techover.technology then techover.technology = {} end

local utils = require("__technology-overload__/" .. "utils")

local MAX_UINT32     = 0xFFFFFFFF
local MAX_INT64      = 0x7FFFFFFFFFFFFFFF
local MAX_DOUBLE     = 0x1.FFFFFFFFFFFFFP+1023

-- Whether a Prototype/Technology has a count_formula or not
-- @ technology: Prototype/Technology
local function hasFormula(technology)
  if technology.unit.count_formula ~= nil then return true end
  return false
end

-- @ technology: Prototype/Technology
local function hasUnit(technology)
  if technology.unit ~= nil then return true end
  return false
end

-- @ technology: Prototype/Technology
local function hasCount(technology)
  if technology.unit.count ~= nil then return true end
  return false
end

-- @ technology: Prototype/Technology
local function getTechnologyUnitCount(technology)
  if hasUnit(technology) then
    if hasCount(technology) then
      return technology.unit.count
    end
  end
  return nil
end

-- @ technology: Prototype/Technology
local function getTechnologyUnitFormula(technology)
  if hasUnit(technology) then
    if hasFormula(technology) then
      return technology.unit.count_formula
    end
  end
  return nil
end

-- @ technologyName: String
-- @ value: int
local function setTechnologyUnitCount(technologyName, value)
  data.raw.technology[technologyName].unit.count = value
end

-- @ technologyName: String
-- @ formula: string
local function setTechnologyUnitFormula(technologyName, formula)
  data.raw.technology[technologyName].unit.count_formula = formula
end

-- @ tech: Tech object
-- cost: number (int/float)
local function applyTechnologyCostModifier(tech, cost, formula)
  if tech.count ~= nil then
    setTechnologyUnitCount(tech.name, cost)
  end
  if tech.formula ~= nil then
    setTechnologyUnitFormula(tech.name, formula)
  end
end

-- @ technology: Prototype/Technology
local function hasPrerequisites(technology)
  if technology.prerequisites ~= nil then return true end
  return false
end

-- @ technology: Prototype/Technology
local function getTechnologyDepth(technology)
  local currentDepth = 1
  if hasPrerequisites(technology) then
    local depths = {}
    for _, prereqsisite in pairs(technology.prerequisites) do
      table.insert(depths, getTechnologyDepth(data.raw.technology[prereqsisite]))
    end
    table.sort(depths)
    return currentDepth + depths[#depths]
  end
  return currentDepth
end

-- @ technology: Prototype/Technology
local function getCumulativeCost(technology)
  local currentCost = getTechnologyUnitCount(technology) or 0
  if hasPrerequisites(technology) then
    local depths = {}
    for _, prereqsisite in pairs(technology.prerequisites) do
      table.insert(depths, getCumulativeCost(data.raw.technology[prereqsisite]))
    end
    return currentCost + utils.sum(depths)
  end
  return currentCost
end
---------------------------------------------------------------------------
-- -- -- Difficulty Levels 
---------------------------------------------------------------------------

-- Funnel
local function difficultyFunnel(techs)
  -- A. get max depth
  local depths = {}
  for _, tech in pairs(techs) do
    table.insert(depths, tech.depth)
  end
  table.sort(depths)
  local maxDepth = depths[#depths]
  -- B. use max depth - depth + 1 as multiplier
  for _, tech in pairs(techs) do
    if tech.count ~= nil then
      local cost = tech.count * (maxDepth - tech.depth + 1)
      setTechnologyUnitCount(tech.name, cost)
    end
    if tech.formula ~= nil then
      local formula = '(' .. tostring(maxDepth - tech.depth + 1) .. '+L)*(' .. tech.formula .. ")"
      setTechnologyUnitFormula(tech.name, formula)
    end
  end
end

-- Miserable Spoon (Funnel Squared * 10)
local function difficultyMiserableSpoon(techs)
  -- A. get max depth
  local depths = {}
  for _, tech in pairs(techs) do
    table.insert(depths, tech.depth)
  end
  table.sort(depths)
  local maxDepth = depths[#depths]
  -- B. use max depth - depth + 1 as multiplier
  for _, tech in pairs(techs) do
    if tech.count ~= nil then
      --local cost = tech.count * (maxDepth * maxDepth * 10 - tech.depth + 1)
      local cost = tech.count * ((maxDepth - tech.depth + 1) * (maxDepth - tech.depth + 1) * 10)
      setTechnologyUnitCount(tech.name, cost)
    end
    if tech.formula ~= nil then
      local formula = '(' .. tostring(maxDepth * maxDepth * 10 - tech.depth + 1) .. '+L)*(' .. tech.formula .. ")"
      setTechnologyUnitFormula(tech.name, formula)
    end
  end
end

-- Tree
local function difficultyTree(techs)
  local TreeCoefficient = settings.startup["to-tree-coefficient"].value or 1
  for _, tech in pairs(techs) do
    --applyTechnologyCostModifier(tech, math.floor(cost), formula)
    if tech.count ~= nil then
      local cost = tech.count * tech.depth * TreeCoefficient
      setTechnologyUnitCount(tech.name, cost)
    end
    if tech.formula ~= nil then
      local formula = 'L*(' .. tech.formula .. ")*" .. tostring(TreeCoefficient)
      setTechnologyUnitFormula(tech.name, formula)
    end
  end
end

-- Mad Tree
local function difficultyMadTree(techs)
  local TreeCoefficient = settings.startup["to-tree-coefficient"].value or 1
  for _, tech in pairs(techs) do
    --applyTechnologyCostModifier(tech, math.floor(cost), formula)
    if tech.count ~= nil then
      local cost = tech.ccost * tech.depth * TreeCoefficient
      setTechnologyUnitCount(tech.name, cost)
    end
    if tech.formula ~= nil then
      local formula = 'L*(' .. tech.formula .. ")*" .. tostring(TreeCoefficient)
      local formula = tech.formula
      formula = formula .. '+' .. tech.ccost
      formula = '(L+' .. tostring(TreeCoefficient * tech.depth) .. ')*(' .. formula .. ')'
      setTechnologyUnitFormula(tech.name, formula)
    end
  end
end

-- Spiral
local function difficultySpiral(techs)
  for _, tech in pairs(techs) do
    --applyTechnologyCostModifier(tech, math.floor(cost), formula)
    if tech.count ~= nil then
      local cost = tech.count * tech.depth
      setTechnologyUnitCount(tech.name, cost)
    end
    if tech.formula ~= nil then
      local formula = '(' .. tostring(tech.depth) .. '+L)*(' .. tech.formula .. ")"
      setTechnologyUnitFormula(tech.name, formula)
    end
  end
end

-- Mad Spiral
local function difficultyMadSpiral(techs)
  for _, tech in pairs(techs) do
    --applyTechnologyCostModifier(tech, math.floor(cost), formula)
    if tech.count ~= nil then
      local cost = tech.ccost * tech.depth
      setTechnologyUnitCount(tech.name, cost)
    end
    if tech.formula ~= nil then
      local formula = '(' .. tostring(tech.depth) .. '+L)*(' .. tech.formula .. ")+" .. tostring(tech.ccost * tech.depth)
      setTechnologyUnitFormula(tech.name, formula)
    end
  end
end

-- Fibonacci
local function difficultyFibonacci(techs)
  for _, tech in pairs(techs) do
    --applyTechnologyCostModifier(tech, math.floor(cost), formula)
    if tech.count ~= nil then
      local cost = tech.ccost
      setTechnologyUnitCount(tech.name, cost)
    end
    if tech.formula ~= nil then
      local formula = tech.formula .. '+' .. tostring(math.floor(tech.ccost))
      setTechnologyUnitFormula(tech.name, formula)
    end
  end
end

-- A Long Way Home
local function difficultyALongWayHome(techs)
  for _, tech in pairs(techs) do
    --applyTechnologyCostModifier(tech, math.floor(cost), formula)
    if tech.count ~= nil then
      local cost = tech.count * tech.depth * tech.depth
      setTechnologyUnitCount(tech.name, cost)
    end
    if tech.formula ~= nil then
      local formula = '(' .. tostring(tech.depth * tech.depth) .. '+L)*(' .. tech.formula .. ")"
      setTechnologyUnitFormula(tech.name, formula)
    end
  end
end

---------------------------------------------------------------------------

techover.technology.getCount          = getTechnologyUnitCount
techover.technology.getFormula        = getTechnologyUnitFormula
techover.technology.getDepth          = getTechnologyDepth
techover.technology.getCumulativeCost = getCumulativeCost
techover.technology.None           = nil
techover.technology.Funnel         = difficultyFunnel
techover.technology.MiserableSpoon = difficultyMiserableSpoon
techover.technology.Tree           = difficultyTree
techover.technology.MadTree        = difficultyMadTree
techover.technology.Spiral         = difficultySpiral
techover.technology.MadSpiral      = difficultyMadSpiral
techover.technology.Fibonacci      = difficultyFibonacci
techover.technology.ALongWayHome   = difficultyALongWayHome