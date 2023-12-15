class ProductsController < ApplicationController
  before_action :initialize_session, only: [:show]
  before_action :load_cart
  before_action :set_product, only: %i[show edit update destroy]

  def index
    initialize_session
    @products = Product.page(params[:page]).per(10)
  end

  def show
    @product = Product.find(params[:id])
    initialize_session if @cart.blank?
  end

  def new
    @product = Product.new
  end

  def edit
    # Your existing code for the edit action
  end

  def create
    @product = Product.new(product_params)
    respond_to_save(:show, "Product was successfully created.")
  end

  def update
    respond_to_save(:show, "Product was successfully updated.")
  end

  def destroy
    @product.destroy!
    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def search
    @keyword = params[:search]
    @category = params[:category]

    Rails.logger.debug "Keyword: #{@keyword}"
    Rails.logger.debug "Category: #{@category}"

    @products = Product.search(@keyword, @category)
    Rails.logger.debug @products.to_sql
  end

  private

  def respond_to_save(action, notice)
    respond_to do |format|
      if @product.save
        format.html { redirect_to product_url(@product), notice: }
        format.json { render action, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:product_name, :price, :stock, :scent, :consistency)
  end
end
