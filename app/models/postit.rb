# -*- encoding : utf-8 -*-
class Postit < ActiveRecord::Base
  acts_as_possession

  belongs_to :board

  def to_s
    self.title
  end

  def self.icon
    "document_64.png"
  end
end
