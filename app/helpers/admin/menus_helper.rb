module Admin::MenusHelper
  # Renders ul list for menu
  # Params:
  # - menu: array with items
  # - options: hash with additional options, such as class name
  def admin_render_menu menu, options = {}
    body = _admin_render_menu menu
    content_tag :ul, body, :class => "menu-admin " + (options[:class] || "")
  end

  private
  def _admin_render_menu menu
    menu.map do |key, item|
      admin_buttons = " ".html_safe
      admin_buttons << content_tag(:span, "", :class => 'glyphicon glyphicon-arrow-up order-up')
      admin_buttons << content_tag(:span, "", :class => 'glyphicon glyphicon-arrow-down order-down')
      admin_buttons << link_to(icon('pencil'), edit_admin_menu_item_path(item[:id]), :data => {:push => true})
      admin_buttons << link_to(icon('trash'), admin_menu_item_path(item[:id]), :method => :delete, :confirm => "#{t("backend_part.confirm")}", :data => {:push => true})

      if item.has_key? :items
        content_tag :li, :data => {:id => item[:id], :order => item[:order]} do
          (item[:title] + admin_buttons + content_tag(:ul, _admin_render_menu(item[:items])).html_safe).html_safe
        end
      else
        content_tag :li, :data => {:id => item[:id], :order => item[:order]} do
          (item[:title] + admin_buttons).html_safe
        end
      end
    end.join.html_safe
  end
end
