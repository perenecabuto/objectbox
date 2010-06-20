class Simpletext < ActiveRecord::Base
  belongs_to :autor

  before_create :set_autor


  def to_s
    self.title
  end

  protected

  def set_autor
    self.autor_id = Authorization.current_user.id
  end

end
