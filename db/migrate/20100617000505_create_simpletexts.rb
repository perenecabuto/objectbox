class CreateSimpletexts < ActiveRecord::Migration
  def self.up
    create_table :simpletexts do |t|
      t.string :title
      t.references :autor
      t.text :content

      t.timestamps
    end
  end

  def self.down
    drop_table :simpletexts
  end
end
