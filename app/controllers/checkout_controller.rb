class CheckoutController < ApplicationController
  def create
    product = Product.find_by(id: params[:id].to_i)

    if product.nil?
      flash[:alert] = 'Product not found'
      redirect_to root_path
      return
    end

    # Create a Price object in your Stripe account for the product
    product_price = Stripe::Price.create(
      product_data: {
        name: product.product_name,
      },
      unit_amount: product.price.to_i,
      currency: 'cad',
    )

    # Establish a connection with Stripe and then redirect the user to the payment screen.
    @session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      mode: 'payment', # Specify the mode for one-time payments
      success_url: checkout_success_url + '?session_id={CHECKOUT_SESSION_ID}',
      cancel_url: checkout_cancel_url,
      line_items: [
        {
          price: product_price.id, # Use the ID of the Price object
          quantity: 1
        },
        {
          price_data: {
            currency: 'cad',
            product_data: {
              name: 'GST',
            },
            unit_amount: (product.price * 0.05).to_i,
          },
          quantity: 1
        }
      ]
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
