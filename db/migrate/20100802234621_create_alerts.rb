# -*- encoding : utf-8 -*-
class CreateAlerts < ActiveRecord::Migration
  def self.up
    create_table :alerts do |t|
      t.string :content
      t.date :alert_date

      t.timestamps
    end
  end

  def self.down
    drop_table :alerts
  end
end
