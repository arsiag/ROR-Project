class UsersController < ApplicationController
  skip_before_action :check_login, only: [:create]
  before_action :check_user, only: [:show]

  def show 
    @user = current_user
    @unsold_shoes = @user.sold_shoes.where(sold: false)
    @sold_shoes = @user.sold_shoes.where(sold: true)
    @bought_shoes = @user.bought_shoes
  end 

  def create
    @user = User.new user_params_create
    if @user.save
      flash[:success] = ["You have successfully created a new user, please login now!"]
      redirect_to "/sessions/new"
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to "/sessions/new"
    end
  end


  private
    def user_params_create
      params.require(:user).permit(:first_name, :last_name, :email, :password)
    end

    def check_user
      if current_user != User.find(params[:id])
        redirect_to "/dashboard/#{session[:user_id]}" 
      end
    end
end
