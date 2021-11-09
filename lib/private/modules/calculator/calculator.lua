local Calculator = {}
local blacklist = {
  "coal-liquefaction"
}

local function isBlacklisted(recipeName)
  for _, name in pairs(blacklist) do
    if recipeName == name then return true end
  end
  return false
end

local function fluidManagement(item, recipeName)
  return (string.sub(item, -7) ~= "-barrel" 
    and string.sub(recipeName, -7) == "-barrel" 
    and (string.sub(recipeName, 1, 5) == "fill-" 
    or string.sub(recipeName, 1, 6) == "empty-"))
end


local function getIngredients(recipe)
  local ingredients = {}
  for i,ingredient in pairs(recipe.ingredients) do
    if (ingredient.name and ingredient.amount) then
      ingredients[ingredient.name] = ingredient.amount
    elseif (ingredient[1] and ingredient[2]) then
      ingredients[ingredient[1]] = ingredient[2]
    end
  end
  return ingredients
end

local function getProducts(recipe)
  local products = {}
  if (recipe.products) then
    for i,product in pairs(recipe.products) do
      if (product.name and product.amount) then
        products[product.name] = product.amount
      elseif product.amount_min and product.amount_max then
        products[product.name] =  (product.amount_min + product.amount_max) / 2 * (product.probability or 1)
      end
    end
  end
  return products
end

local function getRecipes(item)
  local recipes = {}
  for i, recipe in pairs(game.recipe_prototypes) do
    if not isBlacklisted(i) and not fluidManagement(item, i) then
      local products = getProducts(recipe)
      for product, amount in pairs(products) do
        if (product == item) then
          table.insert(recipes, recipe)
        end
      end
    end
  end
  return recipes
end

