function getItemNames(items)
  local tbl = {}
  for _, v in pairs(items) do
    table.insert(tbl, v.name)
  end
  return tbl
end

function getResultNames(RecipeBook)
  local names = {}
  for _, recipe in pairs(RecipeBook) do
    names[recipe.results.name] = 1
  end
  return names
end

function getIngredientNames(RecipeBook)
  local names = {}
  for _, recipe in pairs(RecipeBook) do
    local ingredient_names = getItemNames(recipe.ingredients)
    for _, value in pairs(ingredient_names) do
      names[value] = 1
    end
  end
  return names
end

function getLeftOuts(mainTable, subtractTable)
  local leftOuts = {}
  for mainKey, _ in pairs(mainTable) do
    if not subtractTable[mainKey] then
      leftOuts[mainKey] = 1
    end
  end
  return leftOuts
end