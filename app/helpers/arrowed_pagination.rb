module ArrowedPagination
  class LinkRenderer <  BootstrapPagination::Rails
    protected
    def previous_or_next_page(page, text, classname)
      link_options = @options[:link_options] || {}

      if page
        tag("li", link(text, page, link_options), class: classname)
      end
    end

    def previous_page
      num = @collection.current_page > 1 && @collection.current_page - 1
      t = '<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>'.html_safe
      previous_or_next_page(num, t, 'previous_page')
    end

    def next_page
      num = @collection.current_page < total_pages && @collection.current_page + 1
      t = '<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>'.html_safe
      previous_or_next_page(num, t, 'next_page')
    end
  end
end