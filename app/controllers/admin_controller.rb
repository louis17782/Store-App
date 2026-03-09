class AdminController < ApplicationController
  before_action :authenticate
  def index
    @products = Product.all
  end

  def new
   @product = Product.new
  end

  def create
     Product.create(product_params)
    redirect_to "/admin"
  end

  private
  def product_params
    params.require(:product).permit(:name, :description, :price_usd, :price_bs, :category, :image_url)
  end

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      password == ENV["ADMIN_PASSWORD"]
    end
  end
end
