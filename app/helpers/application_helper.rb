# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  protected

  attr_reader :crumbs

  def crumbs_tag
    @crumbs ||= []

    separator = "</li> <li>→</li> <li>"
    result = %{<li>}
    result += @crumbs.collect{|c| c = c.clone; link_to(c.class == Hash ? c.delete(:label): c, c)}.join(separator)
    result += %{</li>}
    result
  end

  def crumbs_text
    @crumbs.collect {|c| c[:label] || c }.join("→")
  end

  def add_crumb(item)
    @crumbs ||= []
    @crumbs << item
  end

  def model_icon(model)
    return model.icon if model.respond_to?(:icon) and !model.icon.nil?
    return 'warning_64.png' unless model.nil?
  end

  def current_model_icon
    model_icon(current_controller_model)
  end

  def current_controller_model
    controller_name.camelize.singularize.constantize
  rescue NameError
  end

  def current_controller_object
    object = current_controller_model
    object = current_controller_model.send(:find, params[:id]) if params[:id]
    object
  end
end
