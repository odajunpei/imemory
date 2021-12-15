class Admin::OrderProductsController < ApplicationController
  def update
    @order_product = OrderProduct.find(params[:id])
    @order = @order_product.order
		@order_product.update(order_product_params)
		if @order_product.production_status == "製作中"
		   @order.update(received_status:2)
		elsif @order.order_products.count ==  @order.order_products.where(production_status: "製作完了").count
			@order.update(received_status: 3)
		end
		redirect_to request.referer

  end

  private
    def order_product_params
      params.require(:order_product).permit(:production_status)
    end
end
