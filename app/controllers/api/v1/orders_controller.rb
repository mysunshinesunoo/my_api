class Api::V1::OrdersController < ApplicationController
    before_action :set_order, except: [:index, :create]

    def index
        @orders = Order.all
        render json: @orders, include: 'product'
    end

    def show
        render json: @order, include: 'product'
    end

    def destroy
        @order.destroy
        render json: { message: "Order deleted successfully" }, status: :ok
    end

    def create
        @order = Order.new(order_params)
        if @order.save
            render json: { 
                message: "Order created successfully",
                data: @order
            }, status: :created
        else
            render json: @order.errors, status: :unprocessable_entity
        end
    end
    
    def update
        if @order.update(order_params)
            render json: {
                message: "Order updated successfully",
                data: @order
            }, status: :ok
        else
            render json: @order.errors, status: :unprocessable_entity
        end
    end

    private

    def order_params
        params.require(:order).permit(:user_id, :product_id)
    end

    def set_order
      @order = Order.find(params[:id])
    rescue ActiveRecord::RecordNotFound
    	render json: { error: 'Order not found' }, status: :not_found
  	end
end