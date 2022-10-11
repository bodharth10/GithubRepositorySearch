module Pagination
  extend ActiveSupport::Concern

  def default_per_page
    25
  end

  def default_page_no
    1
  end

  def page_sort
    params[:sort]
  end

  def page_no
    params[:page]&.to_i || default_page_no
  end

  def per_page
    params[:per_page]&.to_i || default_per_page
  end
end    