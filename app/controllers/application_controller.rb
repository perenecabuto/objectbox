# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  include ApplicationHelper

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  filter_parameter_logging :password

  before_filter :set_current_user
  before_filter :default_crumbs

  #before_filter :login_required

  protected

  def set_current_user
    Authorization.current_user = current_user
  end

  def default_crumbs
      add_crumb :label => 'Início', :controller => :object_collection
  end

end
