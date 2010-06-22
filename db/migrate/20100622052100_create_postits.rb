class CreatePostits < ActiveRecord::Migration
  def self.up
    create_table :postits do |t|
      t.string :title, :limit => 128
      t.text :content
      t.integer :x
      t.integer :y
      t.string :width, :limit => 8
      t.string :height, :limit => 8
      t.string :background_color, :limit => 16
      t.string :color, :limit => 16
      t.references :board

      t.timestamps
    end
  end

  def self.down
    drop_table :postits
  end
end
