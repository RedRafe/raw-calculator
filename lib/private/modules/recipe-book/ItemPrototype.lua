ItemPrototype = {}
ItemPrototype.__index = ItemPrototype

setmetatable(ItemPrototype, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function ItemPrototype.new(ingredient)
  local self = setmetatable({}, ItemPrototype)

  if not ingredient then return end

  -- Name
  self.name = getIngredientName(ingredient)

  -- Amount, (Min, Max, and Probability)
  self.amount = getIngredientAmount(ingredient)

  -- Type
  self.type = getIngredientType(ingredient)

  -- Temperature
  self.temperature = getIngredientTemperature(ingredient)

  return self
end

function ItemPrototype:get()
  return {
    name = self.name,
    amount = self.amount,
    type = self.type,
    temperature = self.temperature
  }
end
