# -*- encoding : utf-8 -*-
class Simpletext < ActiveRecord::Base
  acts_as_possession

  validates_presence_of :title, :content

  def to_s
    self.title
  end

  def self.icon
    "pencil_64.png"
  end

end
