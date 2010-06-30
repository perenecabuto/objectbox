class Simpletext < ActiveRecord::Base
  acts_as_possession

  def to_s
    self.title
  end

  def self.icon
    "pencil_64.png"
  end

end
