require 'active_record'

# ActsAsPossession
module ActsAsPossession
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def acts_as_possession
      include InstanceMethods
      has_one :owners_possessions, :as => :possession, :autosave => true, :dependent => :destroy, :foreign_key => :possession_id

      alias_attribute :author, :owner
      before_create :associate_owner
      alias_method_chain :owners_possessions, :autobuild
    end

    def acts_as_owner
      include InstanceMethods
      include OwnerInstanceMethods
      has_many :owners_possessions, :as => :owner, :class_name => 'OwnersPossessions'
    end
  end

  module InstanceMethods
    def method_missing(meth, *args, &blk)
      return super if self.respond_to?(meth)
      owners_possessions.send(meth, *args, &blk)
    end

    def owners_possessions_with_autobuild
      owners_possessions_without_autobuild || build_owners_possessions
    end

    def associate_owner
      owners_possessions.owner = Authorization.current_user
    end
  end

  module OwnerInstanceMethods
    def possessions
      owners_possessions.collect {|op| op.possession }
    end
  end

end

ActiveRecord::Base.send(:include, ActsAsPossession)

