# Raw Calculator
A Factorio mod that computes the total raw cost for items' recipes. Raw Calculator will find the shortest path (lowest cost) to craft any item. Intended use for mod developers, does not affect the game.

## Features

- A RecipeBook object is created pushing all the parsed recipes from data.raw.recipe
- Raw Calculator then computes all the recipes raw cost, computing is performed across the recipe tree, bottom-up, time is ~ O(n)
- Raw Calculator already computes the minimum cost possible for recipes
- Value is expressed on total raw resources (e.g.: iron-ore=1, copper-ore=2, automation-science-pack=3)
- Results are logged in the log file
## Future developments

- Add in-game GUI to show exact total raw resources
- Improve compatibility with mods (some recipes might need to be inputted manually maybe)
- Express the raw total for each of the raw resources (e.g.: automation-science-pack = 2 iron-ore, 1 copper-ore)
