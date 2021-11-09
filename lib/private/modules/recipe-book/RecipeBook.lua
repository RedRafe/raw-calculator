RecipeBook = {}

for index, recipe in pairs(data.raw.recipe) do
  local recipe_list = RecipePrototype(recipe)
  for _, entry in pairs(recipe_list:getRecipesList()) do
    table.insert(RecipeBook, entry)
  end
end
