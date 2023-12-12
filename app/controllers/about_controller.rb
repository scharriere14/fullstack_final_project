class AboutController < ApplicationController
  before_action :initialize_session, only: [:index]

  def index
    @products = Product.all
    # @product = Product.find_by(product_name: 'Your Product Name')
    #@product = Product.find_by(id: params[:product_id])

  end

  private

  def set_products
    @products = Product.all
  end

end
