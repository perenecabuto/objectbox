# -*- encoding : utf-8 -*-
class CreateCookingRecipes < ActiveRecord::Migration
  def self.up
    create_table :cooking_recipes do |t|
      t.string :name, :null => false
      t.text :howto_prepare
      t.integer :difficult

      t.timestamps
    end
  end

  def self.down
    drop_table :cooking_recipes
  end
end
