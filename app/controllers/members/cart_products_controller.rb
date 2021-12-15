class Members::CartProductsController < ApplicationController

    def index
        @member = Member.find(current_member.id)
        @cart_products = @member.cart_products.all
    end

    def update
        @cart_product = CartProduct.find(params[:id])
        if @cart_product.update(cart_product_params)
            render :index
        else
            @member = Member.find(current_member.id)
            @cart_products = @member.cart_products.all
            render :index
        end
    end

    def create
        member = Member.find(current_member.id)
        cart_product = member.cart_products.new(cart_product_params)
        if cart_product.save
            redirect_to product_path(cart_product.product_id) ,notice: "カートに#{cart_product.product.name}を追加しました。カート内に#{member.cart_products.count}商品があります。"
        else
            # $error = cart_product
            redirect_to product_path(cart_product.product_id)
            # render template: "products/show.html.erb"
        end
    end

    def destroy
        @cart_product = CartProduct.find(params[:id])
        @cart_product.destroy
        redirect_to cart_products_path
    end

    def destroy_all
        @member = Member.find(current_member.id)
        @cart_products = @member.cart_products.all
        @cart_products.each do |cart_product|
            cart_product.destroy
        end
        redirect_to products_path
    end

private

    def cart_product_params
        params.require(:cart_product).permit(:quantity, :product_id)
    end
end
