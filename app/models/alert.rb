# -*- encoding : utf-8 -*-
class Alert < ActiveRecord::Base
  acts_as_possession

  validates_presence_of :content

  def to_s
    read_attribute :content
  end

  def self.icon
    "alarm-icon.png"
  end
end
