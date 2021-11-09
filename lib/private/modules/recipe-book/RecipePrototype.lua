RecipePrototype = {}
RecipePrototype.__index = RecipePrototype

setmetatable(RecipePrototype, {
  __call = function (cls, ...)
    local class = cls.new(...)
    class:balance()
    return class
  end,
})

function RecipePrototype.new(recipe)
  local self = setmetatable({}, RecipePrototype)

  self.name = recipe.name
  self.ingredients = {}
  self.results = {}

  if not recipe then return end

  for _, item in pairs(getIngredients(recipe)) do
    table.insert(self.ingredients, ItemPrototype(item):get())
  end

  for _, item in pairs(getResults(recipe)) do
    table.insert(self.results, ItemPrototype(item):get())
  end

  return self
end

function RecipePrototype:balance()
  -- Subtract same item/fluid from recipes and ingredients
  for i, result in pairs(self.results) do
    for j, ingredient in pairs(self.ingredients) do
      if (result.name == ingredient.name) and (result.temperature == ingredient.temperature) then
        -- same amount
        if result.amount == ingredient.amount then
          self.results[i] = nil
          self.ingredients[j] = nil
        -- result > ingredient --> production loop
        elseif result.amount > ingredient.amount then
          self.results[i].amount = result.amount - ingredient.amount
          self.ingredients[j] = nil
        -- result < ingredient --> consumption loop
        else
          self.ingredients[j].amount = ingredient.amount - result.amount
          self.results[i] = nil
        end
      end
    end
  end

  -- Remove any 0 yield ItemPrototype
  for i, result in pairs(self.results) do
    if result.amount <= 0 then
      self.results[i] = nil
    end
  end
  for j, ingredient in pairs(self.ingredients) do
    if ingredient.amount <= 0 then
      self.ingredients[j] = nil
    end
  end
end

function RecipePrototype:scaleIngredients(amount)
  local ingredients = {}
  for _, value in pairs(self.ingredients) do
    table.insert(ingredients,
    {
      name = value.name,
      amount = value.amount / amount,
      type = value.type,
      temperature = value.temperature
    })
  end
  return ingredients
end

function RecipePrototype:getRecipesList()
  local combinations = {}
  for i, result in pairs(self.results) do
    table.insert(combinations,
    {
      name = self.name,
      results = {
        name = result.name,
        amount = result.amount / result.amount,
        type = result.type,
        temperature = result.temperature
      },
      ingredients = self:scaleIngredients(result.amount)
    })
  end
  return combinations
end
