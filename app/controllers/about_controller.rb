class AboutController < ApplicationController
  def index
    @products = Product.all
  end

end
