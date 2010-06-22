class Postit < ActiveRecord::Base
  belongs_to :board

  def self.icon
    "document_64.png"
  end
end
