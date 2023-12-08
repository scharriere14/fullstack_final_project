class AboutController < ApplicationController
  before_action :initialize_session, only: [:index]

  def index
    @products = Product.all
  end

  private

  # Remove set_products method if not needed
  # def set_products
  #   @products = Product.all
  # end

end
