class CustomersController < ApplicationController
  # before_action :set_customer, only: %i[show edit update destroy]
  # before_action :authenticate_customer!, only: %i[show edit update destroy]
  before_action :set_customer, only: [:destroy]

  def index
    @customers = Customer.all
  end

  def show
    if customer_signed_in?

      @customer = current_customer
    else
      redirect_to root_path, alert: "Please sign in to view this page."
    end
  end

  def new
    @customer = Customer.new
  end

  def edit
    # Your existing code for the edit action
  end

  def create
    @customer = Customer.new(customer_params)
    @customer.build_address if @customer.address.nil?

    respond_to_save(:show, "Customer was successfully created.")
  end

  def update
    respond_to_save(:show, "Customer was successfully updated.")
  end

  def destroy
    @customer.destroy!
    respond_to do |format|
      format.html { redirect_to customers_url, notice: "Customer was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:email, :customer_first, :customer_last,
                                     address_attributes: %i[id address city postal_code])
  end

  def respond_to_save(action, notice)
    respond_to do |format|
      if @customer.save
        format.html do
          redirect_to action == :show ? customer_url(@customer) : root_path, notice:
        end
        format.json { render action, status: :created, location: @customer }
      else
        format.html { render action == :new ? :new : :edit, status: :unprocessable_entity }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end
end
