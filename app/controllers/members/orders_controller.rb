class Members::OrdersController < ApplicationController

  def new
    @member = Member.find(current_member.id)
    @destination = Destination.new
  end

  def info
    @member = Member.find(current_member.id)
    @cart_products = @member.cart_products.all
    @payment = params[:payment_method] == "0" ? 0 : 1
    if params[:destination_kind] == "0"
      @postal_code = @member.postal_code
      @address = @member.address
      @name = @member.last_name + @member.first_name
    elsif params[:destination_kind] == "1"
      @destination = Destination.find(params[:destinations])
      @postal_code = @destination.postal_code
      @address = @destination.address
      @name = @destination.name
    else
      @destination = Destination.new(destination_params)
      @destination.member_id = current_member.id
      if @destination.save
        @postal_code = @destination.postal_code
        @address = @destination.address
        @name = @destination.name
      else
        render :new
      end
    end
    @order = Order.new
  end

  def create
    order = current_member.orders.new(order_params)
    order.save
    member = Member.find(current_member.id)
    cart_products = member.cart_products.all
    cart_products.each do |cart_product|
      order_product = OrderProduct.new
      order_product.order_id = order.id
      order_product.product_id = cart_product.product_id
      order_product.subtotal_price = cart_product.quantity * ( cart_product.product.price * $tax_rate).floor
      order_product.quantity = cart_product.quantity
      order_product.save
      cart_product.destroy
    end
    #order_product = current_member.order_product.new(order_product_params)
    redirect_to orders_thanks_path
  end

  def thanks
  end

  def index
    @member = Member.find(current_member.id)
    @orders = @member.orders.all
  end

  def show
    if params[:id] == "info"
      redirect_to orders_path
    else
    @member = Member.find(current_member.id)
    @order = @member.orders.find(params[:id])
    end
  end

private

  def destination_params
    params.require(:destination).permit(:member_id,:postal_code, :address, :name)
  end

  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :potage, :total_price, :payment_method, :received_status)
  end

  # def order_product_params
  #   params.require(:order_product).permit(:subtotal_price, :quantity, :production_status)
  # end

end
