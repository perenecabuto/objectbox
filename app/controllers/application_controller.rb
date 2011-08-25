# -*- encoding : utf-8 -*-
# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  include ApplicationHelper

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  before_filter :login_required
  before_filter :set_current_user
  before_filter :default_crumbs

  protected

  def set_current_user
    Authorization.current_user = current_user
  end

  def default_crumbs
      root_route = Rails.application.routes.recognize_path('/')
      crumb_to 'Root', :controller => root_route[:controller]

      if controller_name != root_route[:controller]
        crumb_to controller_name.camelize.singularize, :controller => controller_name
      end

      if params.has_key?:id
        crumb_to current_controller_object, :action => :show
      end

      unless %{index show}.include? action_name
        crumb_to action_name.capitalize
      end
  end

end
