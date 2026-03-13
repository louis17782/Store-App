class AdminController < ApplicationController
  before_action :authenticate
  def index
    @products = Product.all
  end

  def new
   @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to "/admin", notice: "Producto creado exitosamente"
    else
      render :new
    end
  end
  def edit
    @product = Product.find(params[:id])
  end

  def destroy
    Product.find(params[:id]).destroy
    redirect_to "/admin"
  end

  def update
    product = Product.find(params[:id])
    product.update(product_params)
    redirect_to "/admin"
  end

  def retail
    @products = Product.where(category: "Detal")
  end

  def wholesale
    @products = Product.where(category: "Mayor")
  end

  private
  def product_params
    params.require(:product).permit(:name, :description, :price_usd, :price_bs, :category, :quantity, :image)
  end

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      password == ENV["ADMIN_PASSWORD"]
    end
  end
end
