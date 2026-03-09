class CartController < ApplicationController
  def index
    @items = CartItem.where(session_id: session.id)
  end

  def add
    product = Product.find(params[:product_id])

    item = CartItem.find_or_create_by(product_id: product.id, session_id: session.id)
    item.quantity ||= 0
    item.quantity += 1
    item.save
    redirect_to cart_path
  end

  def remove
    CartItem.find(params[:id]).destroy
    redirect_to cart_path
  end

  def update
      item = CartItem.find(params[:id])
      item.quantity = params[:quantity]
      item.save
      redirect_to cart_path
  end
end
