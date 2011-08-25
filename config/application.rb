# -*- encoding : utf-8 -*-
require File.expand_path('../boot', __FILE__)
require 'rails/all'
require File.expand_path('../../lib/authenticated_system', __FILE__)

# If you have a Gemfile, require the gems listed there, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env) if defined?(Bundler)

module Objectbox
  class Application < Rails::Application
    config.filter_parameters = [:password]
    config.active_record.observers = [:user_observer]
    config.time_zone = 'Brasilia'
    config.middleware.use PDFKit::Middleware
  end
end

