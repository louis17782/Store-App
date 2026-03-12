class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
  end

  def set_currency
    session[:currency] = params[:currency]
    redirect_back fallback_location: root_path
  end
end
