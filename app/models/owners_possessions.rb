class OwnersPossessions < ActiveRecord::Base
  belongs_to :owner, :polymorphic => true
  belongs_to :possession, :polymorphic => true

  validates_presence_of :owner, :possession

  default_scope :order => 'updated_at DESC, created_at DESC'
end
