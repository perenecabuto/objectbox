# -*- encoding : utf-8 -*-
class CookingRecipe < ActiveRecord::Base
  #acts_as_possession

  has_and_belongs_to_many :cooking_ingredients,
                          :join_table => :cooking_recipes_ingredients,
                          :foreign_key => :cooking_recipes_id,
                          :association_foreign_key => :cooking_ingredients_id

  DIFFICULTIES = %w{easy normal difficult complex}

  validates_presence_of :name, :difficult
  validates_inclusion_of :difficult, :in => 0 .. DIFFICULTIES.size - 1

  alias_attribute :ingredients, :cooking_ingredients

  def to_s
    self.name
  end

  def dificult
    DIFFICULTIES[read_attribute(:difficult)] if read_attribute(:difficult)
  end

  def dificult=(difficult)
    difficult = DIFFICULTIES.find_index(difficult) if difficult.is_a? String
    write_attribute :difficult, difficult
  end

  def self.difficulties
    DIFFICULTIES
  end

  def self.icon
    "connoisseur-icon.png"
  end
end
