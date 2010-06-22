class Board < ActiveRecord::Base
  validates_presence_of :title, :background
  has_many :postits

  accepts_nested_attributes_for :postits

  def to_s
    self.title
  end

  def self.icon
    "clipboard_64.png"
  end
end
