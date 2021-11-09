---------------------------------------------------------------------------
-- -- -- PRE INITIALIZATION
---------------------------------------------------------------------------
-- General Info
rc                               = {} 
rc.internal_name                 = "raw-calculator"
rc.title_name                    = "Raw Calculator"
rc.version                       = mods[rc.internal_name]
rc.stage                        = "data"

-- -- Global Mod paths
require("__" .. rc.internal_name .. "__/lib/public/paths")

---------------------------------------------------------------------------
-- -- -- CONTENTS INITIALIZATION (data stage)
---------------------------------------------------------------------------
RecipeBook = require(path_m_recipe_book .. "__init__")

log("Length of RecipeBook: " .. tostring(#RecipeBook))