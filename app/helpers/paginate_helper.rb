module PaginateHelper

  def custom_paginate_renderer
    Pagination::CustomPaginateRenderer.new
  end

end