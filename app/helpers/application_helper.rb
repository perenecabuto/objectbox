# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  attr_reader :crumbs

  protected

  def crumbs_tag
    @crumbs ||= []

    result = %{<li>}
    result += @crumbs.collect {|c| link_to(c.class == Hash ? c.delete(:label): c, c) }.join("</li> <li>→</li> <li>")
    result += %{</li>}
    result
  end

  def add_crumb(item)
    @crumbs ||= []
    @crumbs << item
  end

end
