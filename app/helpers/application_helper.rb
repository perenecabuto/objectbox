# -*- encoding : utf-8 -*-
# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  protected

  attr_reader :crumbs

  def crumbs_tag
    @crumbs ||= []

    crumbs_tags = @crumbs.collect do |c|
      current_page?(c.second) ? %(<span class="current">#{c.first}</span>) : link_to(*c)
    end

    raw "<li>#{crumbs_tags.join('</li><li>→</li><li>')}</li>"
  end

  def crumbs_text
    @crumbs ||= []
    @crumbs.collect {|c| c.first }.join(" > ")
  end

  def crumb_to(*args)
    @crumbs ||= []
    args[2] ||= {}
    @crumbs << args
  end

  def current_controller_object
    object = current_controller_model
    object = current_controller_model.send(:find, params[:id]) if params[:id]
    object
  end

  def model_icon(model)
    _icon = 'warning_64.png'
    _icon = model.icon if model and model.respond_to?(:icon) and !model.icon.nil?
    _icon
  end

  def current_model_icon
    model_icon(current_controller_model)
  end

  def current_controller_model
    controller_name.camelize.singularize.constantize
  rescue NameError
  end

end
