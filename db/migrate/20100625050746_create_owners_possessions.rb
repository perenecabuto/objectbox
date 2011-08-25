# -*- encoding : utf-8 -*-
class CreateOwnersPossessions < ActiveRecord::Migration
  def self.up
    create_table :owners_possessions, :id => true do |t|
      t.references :owner, :polymorphic => true, :null => false
      t.references :possession, :polymorphic => true, :null => false

      t.timestamps
    end

    add_index :owners_possessions, [:owner_id, :owner_type,:possession_id, :possession_type], :unique => true, :name => 'owner_possession_uk'
  end

  def self.down
    drop_table :owners_possessions
  end
end
