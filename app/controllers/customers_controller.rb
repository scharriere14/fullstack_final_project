class CustomersController < ApplicationController
  before_action :set_customer, only: %i[show edit update destroy]

  def index
    @customers = Customer.all
  end

  def show
    # Your existing code for the show action
  end

  def new
    @customer = Customer.new
  end

  def edit
    # Your existing code for the edit action
  end

  def create
    @customer = Customer.new(customer_params)
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
    params.require(:customer).permit(:customer_first, :customer_last, :email_address)
  end

  def respond_to_save(action, notice)
    respond_to do |format|
      if @customer.save
        format.html { redirect_to customer_url(@customer), notice: }
        format.json { render action, status: :created, location: @customer }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end
end
