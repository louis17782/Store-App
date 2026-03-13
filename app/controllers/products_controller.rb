class ProductsController < ApplicationController
  def index
    @products = Product.where(category: "Detal")
  end

  def show
  end

  def retail
   @products = Product.where(category: "Detal")
  end

  def wholesale
    @products = Product.where(category: "Mayor")
  end

  def set_currency
    session[:currency] = params[:currency]
    redirect_back fallback_location: root_path
  end
end
