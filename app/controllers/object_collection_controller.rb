class ObjectCollectionController < ApplicationController

    before_filter :login_required

    def index
      @models = Dir['app/models/*.rb'].map {|f| File.basename(f, '.*').camelize.constantize }.select {|m|
          m.respond_to? :new and m.ancestors.include? ActiveRecord::Base
      }
    end

end
