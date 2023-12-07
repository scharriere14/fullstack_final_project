# app/controllers/search_controller.rb
class SearchController < ApplicationController
  def index
    @search_results = Product.where("product_name LIKE ?", "%#{params[:search]}%")
  end
end
