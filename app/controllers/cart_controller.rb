class CartController < ApplicationController
  def index
    @items = CartItem.where(session_id: current_Session).order(:id)
  end

  def add
    product = Product.find(params[:product_id])

    item = CartItem.find_or_initialize_by(product_id: product.id, session_id: current_Session)

    item.quantity ||= 0
    if item.quantity < product.quantity
      item.quantity += 1
      item.save
    end
    @items = CartItem.where(session_id: current_Session).order(:id)
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to cart_path }
    end
  end

  def remove
    @item = CartItem.find(params[:id])
    @item.destroy

    @items = CartItem.where(session_id: current_Session).order(:id)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to products_path }
    end
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
    @items = CartItem.where(session_id: current_Session).order(:id)
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
    @items = CartItem.where(session_id: current_Session).order(:id)
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to cart_path }
    end
  end

  def checkout
    @items = CartItem.where(session_id: current_Session).order(:id)

    if @items.empty?
      redirect_to cart_path, alert: "Tu carrito está vacío"
    end
  end

  # ✅ ENVÍA A WHATSAPP
  def send_order
    name = params[:name]
    phone = params[:phone]
    address = params[:address]
    delivery = params[:delivery]
    payment = params[:payment]
    cedula = params[:cedula]
    agency = params[:agency]

    items = CartItem.where(session_id: current_Session).order(:id)

    # 🔒 validar stock antes de enviar
    items.each do |item|
      if item.quantity > item.product.quantity
        redirect_to cart_path, alert: "Stock insuficiente para #{item.product.name}"
        return
      end
    end

  currency = session[:currency] || "usd"

  # Calcular total
  total = items.sum do |item|
    price = currency == "bs" ? item.product.price_bs : item.product.price_usd
    price * item.quantity
  end

  formatted_total = currency == "bs" ? "Bs #{total}" : "$#{total}"


    # 📦 construir productos
    products = items.map do |item|
      "• #{item.product.name} x#{item.quantity}"
    end.join("\n")
    message = <<~TEXT
    🛒 *Nuevo Pedido*
    👤 Nombre: #{name}
    📞 Teléfono: #{phone}
    📍 Dirección: #{address}
    🚚 Entrega: #{delivery}
    #{delivery == "Envío nacional" ? "🪪 Cédula: #{cedula}\n🏢 Agencia: #{agency}" : ""}
    💳 Pago: #{payment}
    📦 Productos: #{products}
    *Total a pagar: #{formatted_total}*

    TEXT
    encoded_message = ERB::Util.url_encode(message)

    items.each do |item|
      product = item.product
      product.update(quantity: product.quantity - item.quantity)
    end
    # limpiar carrito
    items.destroy_all
    redirect_to "https://wa.me/584245647331?text=#{encoded_message}", allow_other_host: true
  end
  def success
  end
end
