# app/controllers/search_controller.rb
class SearchController < ApplicationController
  def index
    keyword = params[:search]
    category = params[:category]

    @search_results = if keyword.present? || category.present?
                        Product.search(keyword, category)
                      else
                        Product.none
                      end
  end
end
