database_techs = {}

-- A. iterate data.raw and save technology info
for _, _technology in pairs(data.raw.technology) do
  local _tech = {}

  _tech.name    = _technology.name
  _tech.count   = techover.technology.getCount(_technology)
  _tech.formula = techover.technology.getFormula(_technology)
  _tech.depth   = techover.technology.getDepth(_technology)
  _tech.ccost   = techover.technology.getCumulativeCost(_technology)

  table.insert(database_techs, _tech)
end

-- B. get settings from startup
local difficulty = settings.startup["to-difficulty"].value

-- C. apply difficulty multiplier
if difficulty == "None" then
  --pass
elseif difficulty == "Funnel" then
  techover.technology.Funnel(database_techs)
elseif difficulty == "Miserable Spoon" then
  techover.technology.MiserableSpoon(database_techs)
elseif difficulty == "Spiral" then
  techover.technology.Spiral(database_techs)
elseif difficulty == "Mad Spiral" then
  techover.technology.MadSpiral(database_techs)
elseif difficulty == "Tree" then
  techover.technology.Tree(database_techs)
elseif difficulty == "Mad Tree" then
  techover.technology.MadTree(database_techs)
elseif difficulty == "Fibonacci" then
  techover.technology.Fibonacci(database_techs)
elseif difficulty == "A Long Way Home" then
  techover.technology.ALongWayHome(database_techs)
end