class ApplicationController < ActionController::Base
  before_action :initialize_session
  before_action :load_cart

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

  def after_sign_in_path_for(resource)
    if resource.is_a?(Customer)
      root_path # or any other path you want to redirect to
    else
      super
    end
  end

  def after_sign_out_path_for(_resource_or_scope)
    root_path
  end

  private

  # def load_cart
  #   @cart = Product.find(session[:cart])
  # end
  def initialize_session
    session[:cart] ||= [] # Initialize session[:cart] to an empty array if it's nil
    @cart = session[:cart]
    @cart_products = @cart.present? ? Product.where(id: @cart) : []

    # Ensure @cart is set even if it's empty
    @initialize_session ||= []
  end

  def load_cart
    Rails.logger.debug "Cart: #{@cart.inspect}"
    @cart = session[:cart]
    @cart_products = @cart.present? ? Product.where(id: @cart) : []
    @cart_total = calculate_total(@cart_products)
    Rails.logger.debug "Cart Total: #{@cart_total.inspect}"
  end

  def calculate_total(products)
    products.sum(&:price).to_i
  end
end
