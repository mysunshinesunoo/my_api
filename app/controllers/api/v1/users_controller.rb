class Api::V1::UsersController < ApplicationController
  before_action :set_user, except: [:index, :create]
  
  def index
    @users = User.all 
    render json: { message: "success", data: @users }
  end

  def show
    render json: @user
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render json: { 
                message: "User created successfully",
                data: @user
            }, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: {
                message: "User updated successfully",
                data: @user
            }, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    render json: { message: "User deleted successfully" }, status: :ok
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :phone_number)
  end

  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'User not found' }, status: :not_found
  end
end

