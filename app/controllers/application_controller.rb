class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authorize

  helper_method :current_user
  
  protected
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    else
      @current_user = nil
    end
  end

  def authorize
    redirect_to login_path(:before_login_path => request.path), alert: 'You must be logged in to access this page.' if current_user.nil?
  end

  def drop_session
    session[:user_id] = nil
  end

  def custom_paginate_renderer
    Class.new(WillPaginate::ActionView::LinkRenderer) do
      def container_attributes
        {class: "pagination"}
      end
    
      def page_number(page)
        if page == current_page
          "<li class='page-item active' aria-current='page'>"+link(page, page, rel: rel_value(page))+"</li>"
        else
          "<li class='page-item'>"+link(page, page, rel: rel_value(page))+"</li>"
        end
      end
    
      def previous_page
        num = @collection.current_page > 1 && @collection.current_page - 1
        previous_or_next_page(num, "<li class='page-item'>&laquo;</li>")
      end
    
      def next_page
        num = @collection.current_page < total_pages && @collection.current_page + 1
        previous_or_next_page(num, "<li class='page-item'>&raquo;</li>")
      end
    
      def previous_or_next_page(page, text)
        if page
          "<li class='page-item'>"+link(text, page)+"</li>"
        else
          "<li class='page-item'>"+text+"</li>"
        end
      end
      end
    end

end
