# app > controllers && controllers > checkout_controller.rb
class CheckoutController < ApplicationController
  include GstCalculator

  before_action :authenticate_user!, only: [:create]

  def create
    product_ids = @cart.to_a

    if product_ids.empty?
      handle_empty_cart
      return
    end

    log_product_ids(product_ids)
    products = retrieve_products(product_ids)
    calculate_and_store_total(products)
    process_checkout(product_ids)
  end

  def success
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
  end

  def cancel
    # Something went wrong with the payment :(
  end

  private

  def log_product_ids(product_ids)
    Rails.logger.debug "Product IDs: #{product_ids.inspect}"
  end

  def retrieve_products(product_ids)
    Product.find(product_ids)
  end

  def calculate_and_store_total(products)
    @total = calculate_total(products)
    session[:cart_total] = @total
  end

  def authenticate_user!
    # Use Devise helper method to check if the user is signed in
    return if customer_signed_in?

    flash[:alert] = "You must be logged in to proceed with the checkout."
    redirect_to new_user_session_path
  end

  def handle_empty_cart
    flash[:alert] = "Your cart is empty"
    @total = 0
    redirect_to root_path
  end

  def process_checkout(product_ids)
    products = Product.find(product_ids)
    line_items = build_line_items(products)
    gst_item = build_gst_item(products)
    line_items << gst_item
    @session = create_stripe_session(line_items)
    redirect_to_payment_screen
  end

  def build_line_items(products)
    products.map { |product| build_line_item(product) }
  end

  def build_line_item(product)
    {
      price_data: build_price_data(product),
      quantity:   1
    }
  end

  def build_price_data(product)
    {
      currency:     "cad",
      product_data: build_product_data(product),
      unit_amount:  product.price.to_i
    }
  end

  def build_product_data(product)
    {
      name: product.product_name
    }
  end

  # Removed the duplicate methods build_gst_item and calculate_gst_amount
  # as they are now included from the GstCalculator concern.

  def create_stripe_session(line_items)
    Stripe::Checkout::Session.create(
      payment_method_types: ["card"],
      mode:                 "payment",
      success_url:          "#{checkout_success_url}?session_id={CHECKOUT_SESSION_ID}",
      cancel_url:           checkout_cancel_url,
      line_items:
    )
  end

  def redirect_to_payment_screen
    redirect_to @session.url, allow_other_host: true
  end
end
