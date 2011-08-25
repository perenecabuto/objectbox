# -*- encoding : utf-8 -*-
class CookingIngredient < ActiveRecord::Base
    has_and_belongs_to_many :cooking_recipes, :class_name => "CookingRecipesIngredients"

    has_and_belongs_to_many :cooking_recipes,
                          :join_table => :cooking_recipes_ingredients,
                          :foreign_key => :cooking_ingredients_id,
                          :association_foreign_key => :cooking_recipes_id

    def self.icon
      "ingredient.png"
    end
end
