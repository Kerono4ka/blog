module PaginateHelper

  class CustomPaginateRenderer < WillPaginate::ActionView::LinkRenderer
    def container_attributes
      {class: "pagination pagination-sm"}
    end
  
    def page_number(page)
      if page == current_page
        "<li class='page-item active' aria-current='page'>"+
        link(page, page, rel: rel_value(page), class: "page-link")+"</li>"
      else
        "<li class='page-item'>"+link(page, page, rel: rel_value(page), class: "page-link")+"</li>"
      end
    end
  
    def previous_page
      num = @collection.current_page > 1 && @collection.current_page - 1
      previous_or_next_page(num, "&laquo;")
    end
  
    def next_page
      num = @collection.current_page < total_pages && @collection.current_page + 1
      previous_or_next_page(num, "&raquo;")
    end
  
    def previous_or_next_page(page, text)
      if page
        "<li class='page-item'>"+link(text, page, class: "page-link")+"</li>"
      else
        "<li class='page-item'><a class='page-link' aria-disabled='true'>"+text+"</a></li>"
      end
    end
  end

  def custom_paginate_renderer
    CustomPaginateRenderer.new
  end

end