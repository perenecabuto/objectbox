# -*- encoding : utf-8 -*-
class CreateCookingIngredients < ActiveRecord::Migration
  def self.up
    create_table :cooking_ingredients do |t|
      t.string :description, :null => false
      t.string :unit, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :cooking_ingredients
  end
end
