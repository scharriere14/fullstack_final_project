# app/controllers/search_controller.rb
class SearchController < ApplicationController
  def index
    keyword = params[:search]
    category = params[:category]

    if keyword.present? || category.present?
      @search_results = Product.search(keyword, category)
    else
      @search_results = Product.none
    end
  end
end
