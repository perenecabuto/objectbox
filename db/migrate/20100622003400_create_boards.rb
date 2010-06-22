class CreateBoards < ActiveRecord::Migration
  def self.up
    create_table :boards do |t|
      t.string :title, :limit => 128, :null => false
      t.string :background, :limit => 128, :null => false
      t.numeric :revision

      t.timestamps
    end
  end

  def self.down
    drop_table :boards
  end
end
