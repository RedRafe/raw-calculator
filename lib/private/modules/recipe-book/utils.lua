---------------------------------------------------------------------------
--                            HELPER FUNCTIONS                           --
---------------------------------------------------------------------------

function getIngredientName(ingredient)
  return ingredient.name or ingredient[1]
end

function getIngredientAmount(ingredient)
  if ingredient.amount then 
    return ingredient.amount 
  elseif ingredient[2] then
    return ingredient[2]
  elseif ingredient.amount_min and ingredient.amount_max and ingredient.probability then
    local _min = ingredient.amount_min
    local _max = ingredient.amount_max
    local _p = ingredient.probability
    if _max < _min then _max = _min end
    return (_min + _max) / 2 * (_p or 1)
  else
    return nil
  end
end

function getIngredientType(ingredient)
  return ingredient.type or "item"
end

function getIngredientTemperature(ingredient)
  return ingredient.temperature
end

function resultToResults(recipe)
  local results = nil

  if recipe.results then
    results = recipe.results
  elseif recipe.normal and recipe.normal.results then
    results = recipe.normal.results
  elseif recipe.expensive and recipe.expensive.results then
    results = recipe.expensive.results
  end

  if not results then
    local result_count = 1
    if recipe.result then
      result_count = recipe.result_count or 1
      if type(recipe.result) == "string" then
        recipe.results = { { type = "item", name = recipe.result, amount = result_count } }
      elseif recipe.result.name then
        recipe.results = { recipe.result }
      elseif recipe.result[1] then
        result_count = recipe.result[2] or result_count
        recipe.results = { { type = "item", name = recipe.result[1], amount = result_count } }
      end
      recipe.result = nil
      results = recipe.results
      recipe.result_count = nil
    end
    if not results and recipe.normal and recipe.normal.result then
      result_count = recipe.normal.result_count or 1
      if type(recipe.normal.result) == "string" then
        recipe.normal.results = { { type = "item", name = recipe.normal.result, amount = result_count } }
      elseif recipe.normal.result.name then
        recipe.normal.results = { recipe.normal.result }
      elseif recipe.normal.result[1] then
        result_count = recipe.normal.result[2] or result_count
        recipe.normal.results = { { type = "item", name = recipe.normal.result[1], amount = result_count } }
      end
      recipe.normal.result = nil
      results = recipe.normal.results
      recipe.normal.result_count = nil
    end
    if recipe.expensive and recipe.expensive.result then
      result_count = recipe.expensive.result_count or 1
      if type(recipe.expensive.result) == "string" then
        recipe.expensive.results = { { type = "item", name = recipe.expensive.result, amount = result_count } }
      elseif recipe.expensive.result.name then
        recipe.expensive.results = { recipe.expensive.result }
      elseif recipe.expensive.result[1] then
        result_count = recipe.expensive.result[2] or result_count
        recipe.expensive.results = { { type = "item", name = recipe.expensive.result[1], amount = result_count } }
      end
      recipe.expensive.result = nil
      recipe.expensive.result_count = nil
      if not results then
        results = recipe.expensive.results
      end
    end
  end
  return results
end

function getResults(recipe)
  if recipe then
    results = resultToResults(recipe)
    if results == nil then
      results = {}
    end
    return results
  end
  return {}
end

function getIngredients(recipe)
  if recipe then
    if recipe.ingredients then
      return recipe.ingredients
    end
    if recipe.normal and recipe.normal.ingredients then
      return recipe.normal.ingredients
    end
  end
  return {}
end

function countProduct(recipe, product_name)
  local results = getResults(recipe)
  if results and #results > 0 then
    local inner_product_name = nil
    for i = 1, #results do
      inner_product_name = getIngredientName(results[i])
      if inner_product_name == product_name then
        return getIngredientAmount(results[i])
      end
    end
  end
  return 0
end

---------------------------------------------------------------------------