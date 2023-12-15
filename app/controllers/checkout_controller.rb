# app > controllers && controllers > checkout_controller.rb
class CheckoutController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    product_ids = @cart.to_a

    if product_ids.empty?
      handle_empty_cart
      return
    end

    Rails.logger.debug "Product IDs: #{product_ids.inspect}"

    # Retrieve products based on IDs
    Product.find(product_ids)

    # Display total in cart
    # @total = calculate_total(products)
    products = Product.find(product_ids)

    @total = calculate_total(products)
    session[:cart_total] = @total # Store the total in the session

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
    Rails.logger.debug "Product: #{product.product_name}, Price: #{product.price}, Unit Amount: #{product.price}"

    {
      price_data: {
        currency:     "cad",
        product_data: {
          name: product.product_name
        },
        unit_amount:  product.price.to_i
      },
      quantity:   1
    }
  end

  def build_gst_item(products)
    {
      price_data: {
        currency:     "cad",
        product_data: {
          name: "GST"
        },
        unit_amount:  calculate_gst_amount(products)
      },
      quantity:   1
    }
  end

  def calculate_total(products)
    return 0 if products.blank? # Check if cart_products is nil or empty

    products.sum(&:price).to_i
  end

  def calculate_gst_amount(products)
    (products.sum(&:price) * 0.05).to_i
  end

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
