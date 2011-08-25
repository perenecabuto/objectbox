# -*- encoding : utf-8 -*-
require 'foreigner'

class CreateCookingRecipesIngredients < ActiveRecord::Migration
  def self.up
    create_table :cooking_recipes_ingredients, :id => false do |t|
      t.references :cooking_ingredients, :null => false
      t.references :cooking_recipes, :null => false

      t.timestamps
    end

    add_foreign_key :cooking_recipes_ingredients, :cooking_ingredients
    add_foreign_key :cooking_recipes_ingredients, :cooking_recipes
  end

  def self.down
    drop_table :cooking_recipes_ingredients
  end
end
