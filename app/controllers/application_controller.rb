# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  include ApplicationHelper

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  filter_parameter_logging :password

  before_filter :login_required
  before_filter :set_current_user
  before_filter :default_crumbs

  protected

  def set_current_user
    Authorization.current_user = current_user
  end

  def default_crumbs
      root_route = ActionController::Routing::Routes.recognize_path(root_path)
      add_crumb :label => 'Root', :controller => root_route[:controller]

      if controller_name != root_route[:controller]
        add_crumb :label => controller_name.camelize, :controller => controller_name
      end

      if params.has_key?:id
        add_crumb current_controller_object
      end

      add_crumb :label => action_name.camelize, :controller => controller_name unless %w{index show}.include? action_name
  end

end
