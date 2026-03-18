class ProductsController < ApplicationController
  def index
       @products = Product.all
    if params[:category_id].present?
      @products = @products.where(category_id: params[:category_id])
    end
    if params[:sale_type].present?
      @products = @products.where(sale_type: params[:sale_type])
    end
    @items = CartItem.where(session_id: current_Session)
  end

  def show
  end

  def set_currency
    session[:currency] = params[:currency]
    redirect_back fallback_location: root_path
  end
end
