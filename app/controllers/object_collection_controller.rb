class ObjectCollectionController < ApplicationController

    before_filter :login_required

    def index
      @models = Dir['app/models/*.rb'].map {|f| File.basename(f, '.*').camelize.constantize }.select {|m|
          m.respond_to? :new and m.ancestors.include? ActiveRecord::Base and
          ActionController::Routing.possible_controllers.include? m.to_s.tableize
      }
    end

end
