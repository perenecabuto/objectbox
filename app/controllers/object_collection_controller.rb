# -*- encoding : utf-8 -*-
class ObjectCollectionController < ApplicationController
  before_filter :login_required

  def index
    @models = Dir['app/models/*.rb'].map {|f| File.basename(f, '.*').camelize.constantize }.select {|m|
      m.respond_to? :new and m.ancestors.include? ActiveRecord::Base and
      Rails.application.routes.routes.collect {|r| r.requirements[:controller] }.include? m.to_s.tableize
    }
  end

end
