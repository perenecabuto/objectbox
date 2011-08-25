# -*- encoding : utf-8 -*-
class CookingRecipesIngredients < ActiveRecord::Base
  belongs_to :cooking_ingredient, :foreign_key => :cooking_ingredients_id
  belongs_to :cooking_recipe, :foreign_key => :cooking_recipes_id
end
