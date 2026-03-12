class CartController < ApplicationController
  def index
    @items = CartItem.where(session_id: current_Session)
  end

  def add
    product = Product.find(params[:product_id])

    item = CartItem.find_or_initialize_by(product_id: product.id, session_id: current_Session)

    item.quantity ||= 0
    if item.quantity < product.quantity
      item.quantity += 1
      item.save
    end
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to cart_path }
    end
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

  def increase
    item = CartItem.find(params[:id])
    product = item.product
    if item.quantity < product.quantity
      item.quantity += 1
      item.save
    end
    @items = CartItem.where(session_id: current_Session)
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to cart_path }
    end
  end

  def decrease
    item = CartItem.find(params[:id])
    if item.quantity > 1
      item.quantity -= 1
      item.save
    end
    @items = CartItem.where(session_id: current_Session)
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to cart_path }
    end
  end

  def checkout
    items = CartItem.where(session_id: current_Session)
    items.each do |item|
      product = item.product
      if item.quantity > product.quantity
        redirect_to cart_path, alert: "No hay suficiente stock para #{product.name}"
        return
      end
    end
    items.each do |item|
      product = item.product
      product.update(quantity: product.quantity - item.quantity)
    end
    items.destroy_all
    redirect_to order_success_path
  end

  def success
  end
end
