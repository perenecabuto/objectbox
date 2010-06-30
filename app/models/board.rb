class Board < ActiveRecord::Base
  acts_as_possession

  validates_presence_of :title, :background
  has_many :postits

  accepts_nested_attributes_for :postits

  serialize :background

  def to_s
    self.title
  end

  def self.icon
    "clipboard_64.png"
  end
end
