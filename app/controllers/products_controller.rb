class ProductsController < ApplicationController
  before_action :initialize_session
  before_action :load_cart

  # GET /products or /products.json
  def index
    initialize_session
    @products = Product.paginate(page: params[:page], per_page: 10)
  end

  # GET /products/1 or /products/1.json
  def show
    @product = Product.find(params[:id])
   # @cart_products = get_cart_products
  # @cart = cart_products
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to product_url(@product), notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to product_url(@product), notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy!

    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # def add_to_cart
  #   id = params[:id].to_i
  #   session[:cart] << id unless session[:cart].include?(id)
  #   redirect_to root_path
  # end

  # def remove_from_cart
  #   id = params[:id].to_i
  #   session[:cart].delete(id)
  #   redirect_to root_path
  # end




  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product).permit(:product_name, :price, :stock, :scent, :consistency)
  end

  def search
    @search_results = Product.search(params[:search])
  end
end
