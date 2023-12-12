class CheckoutController < ApplicationController
  def create
    # Load all products in the cart
    product_ids = @cart.to_a

    if product_ids.empty?
      flash[:alert] = 'Your cart is empty'
      redirect_to root_path
      return
    end

    # Fetch the corresponding Product records
    products = Product.find(product_ids)

    # Create an array of line items for the session
    line_items = products.map do |product|
      {
        price_data: {
          currency: 'cad',
          product_data: {
            name: product.product_name,
          },
          unit_amount: product.price.to_i, # Assuming the price is in whole units
        },
        quantity: 1
      }
    end

    # Add the GST as a separate line item
    line_items << {
      price_data: {
        currency: 'cad',
        product_data: {
          name: 'GST',
        },
        unit_amount: (products.sum(&:price) * 0.05).to_i, # Total GST for all products
      },
      quantity: 1
    }

    # Establish a connection with Stripe and then redirect the user to the payment screen.
    @session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      mode: 'payment',
      success_url: checkout_success_url + '?session_id={CHECKOUT_SESSION_ID}',
      cancel_url: checkout_cancel_url,
      line_items: line_items
    )

    # Redirect the user to the payment screen.
    redirect_to @session.url, allow_other_host: true
  end

  def success
    # We took the customer's money!
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
  end

  def cancel
    # Something went wrong with the payment :(
  end
end
