class AddressesController < ApplicationController
  before_action :set_address, only: %i[show edit update destroy]

  def index
    @addresses = Address.all
  end

  def show
    # GET /addresses/1 or /addresses/1.json
  end

  def new
    # GET /addresses/new
    @address = Address.new
  end

  def edit
    # GET /addresses/1/edit
  end

  def create
    # POST /addresses or /addresses.json
    @address = Address.new(address_params)
    respond_to_creation("Address was successfully created.")
  end

  def update
    # PATCH/PUT /addresses/1 or /addresses/1.json
    respond_to_creation("Address was successfully updated.")
  end

  def destroy
    # DELETE /addresses/1 or /addresses/1.json
    @address.destroy!
    respond_to do |format|
      format.html { redirect_to addresses_url, notice: "Address was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_address
    # Use callbacks to share common setup or constraints between actions.
    @address = Address.find(params[:id])
  end

  def address_params
    # Only allow a list of trusted parameters through.
    params.require(:address).permit(:address, :city, :province, :postal_code)
  end

  def respond_to_creation(notice_message)
    respond_to do |format|
      if @address.save
        format.html { redirect_to address_url(@address), notice: notice_message }
        format.json { render :show, status: :created, location: @address }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end
end
