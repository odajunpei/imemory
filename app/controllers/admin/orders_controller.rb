class Admin::OrdersController < ApplicationController

  def index
    if params[:name].present?
      member = Member.find(params[:name])
      @orders = member.orders.page(params[:page]).per(14).order("#{sort_column} #{sort_direction}")
    elsif params[:received].present?
      received = params[:received]
      @orders = Order.where(received_status: received.to_i).page(params[:page]).per(14).order("#{sort_column} #{sort_direction}")
    else
      @orders = Order.page(params[:page]).per(14).order("#{sort_column} #{sort_direction}")
    end
  end

  def show
    @order = Order.find(params[:id])
    @order_products = @order.order_products
  end

  def update
    @order = Order.find(params[:id])
    @order_products = @order.order_products
    @order.update(order_params)
		if @order.received_status == "入金確認"
		   @order_products.update_all(production_status:1)
		end
		   redirect_to request.referer

  end

  def sort_direction
    %w[desc asc].include?(params[:direction]) ? params[:direction] : 'desc'
  end

  def sort_column
    Order.column_names.include?(params[:sort]) ? params[:sort] : 'created_at'
  end

  private

    def order_params
      params.require(:order).permit(:received_status)
    end

end
