table.insert(RecipeBook, {
  name = 'space-science-pack',
  results = {
    name = 'space-science-pack',
    amount = 1,
    type = 'item',
    temperature = nil
  },
  ingredients = {
    {
      name = 'rocket-part',
      amount = 0.1,
      type = 'item',
      temperature = nil
    }
  }
})

local resultNames = getResultNames(RecipeBook)
local ingredientNames = getIngredientNames(RecipeBook)
local basicItems = getLeftOuts(ingredientNames, resultNames)

local defaultBasicItems = {
  ['water'] = 0,
  ['steam'] = 0
}

local ignoreBasicItems = {
  'used-up-uranium-fuel-cell'
}

Items:set(basicItems)
Items:set(defaultBasicItems)
Items:delete(ignoreBasicItems)
Items:printDataset()

local previous_length = -1
local current_length = Items:getLength()

while(previous_length < current_length) do
  log('Computing recipe costs... ' .. tostring(current_length) .. '/' .. tostring(#RecipeBook))
  for _, recipe in pairs(RecipeBook) do
    local result = recipe.results.name
    local ingredients = getItemNames(recipe.ingredients)

    -- recipe already discovered
    if Items:hasValues(ingredients) then
      -- compute new value for the result
      local sum = 0
      for _, ingredient in pairs(recipe.ingredients) do
        sum = sum + ingredient.amount * Items.value[ingredient.name]
      end
      Items:set({[result] = sum})
      --Items:set({[result] = sum / result.amount})
    end
  end
  previous_length = current_length
  current_length = Items:getLength()
end

Items:printDataset()
