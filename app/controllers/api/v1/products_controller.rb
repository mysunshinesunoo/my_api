class Api::V1::ProductsController < ApplicationController
  before_action :set_product, except: [:index, :create]

    def index
        @products = Product.all
        render json: @products
    end

    def create
        @product = Product.new(product_params)
        if @product.save
            render json: {
                message: "Product created successfully",
                data: @product
            }, status: :created
        else
            render json: @product.errors, status: :unprocessable_entity
        end
    end

    def show
        render json: @product
    end
    
    def update
        if @product.update(product_params)
            render json: {
                message: "Product updated successfully",
                data: @product
            }, status: :ok
        else
            render json: @product.errors, status: :unprocessable_entity
        end
    end

    def destroy
        @product.destroy
        render json: { message: "Product deleted successfully" }, status: :ok
    end

    private

    def product_params
        params.require(:product).permit(:product_name)
    end

    def set_product
        @product = Product.find(params[:id])
    rescue ActiveRecord::RecordNotFound
    render json: { error: 'Product not found' }, status: :not_found
    end
end