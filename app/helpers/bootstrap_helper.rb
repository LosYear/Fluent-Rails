module BootstrapHelper
  def icon icon_name
    content_tag 'span', "", class: "glyphicon glyphicon-" + icon_name
  end

  # @param [array] breadcrumbs
  # Generates Bootstrap breadcrumbs
  def breadcrumbs_helper breadcrumbs, home_url = admin_path
    if breadcrumbs != nil && !breadcrumbs.empty?
      content_tag :ol, :class => 'breadcrumb' do
        concat content_tag :li, link_to(t('backend_part.home'), home_url, :data => {:push => true})

        breadcrumbs.each do |element|
          if element.has_key? :link
            concat content_tag :li, link_to(element[:title], element[:link], :data => {:push => true})
          elsif element.has_key? :title
            concat content_tag :li, element[:title], :class => 'active'
          end
        end
      end
    end
  end

  # Generates Bootstrap navlist
  # @param [array] items
  def nav_menu_list_helper items
    unless items.empty?
      content_tag :ul, :class => 'nav nav-list' do
        content = ""
        items.each do |item|
          content << if item.has_key? :icon
                       content_tag :li do
                         link_to icon(item[:icon]) + ' ' + item[:title], item[:link], :data => {:push => true}
                       end
                     else
                       link_to item[:title], item[:link], :data => {:push => true}
                     end
        end
        content.html_safe
      end
    end
  end


end