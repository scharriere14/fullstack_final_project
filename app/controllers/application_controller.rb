class ApplicationController < ActionController::Base
  before_action :initialize_session
  before_action :authenticate_customer!


  def add_to_cart
    id = params[:id].to_i
    session[:cart] << id unless session[:cart].include?(id)
    redirect_to root_path
  end

  def remove_from_cart
    id = params[:id].to_i
    session[:cart].delete(id)
    redirect_to root_path
  end

  private

  def initialize_session
    session[:cart] ||= [] # Initialize session[:cart] to an empty array if it's nil
    @cart = session[:cart]
    @cart_products = @cart.present? ? Product.where(id: @cart) : []
  end
end

def load_cart
  @cart = Product.find(session[:cart])
end
