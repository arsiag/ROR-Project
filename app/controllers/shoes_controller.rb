class ShoesController < ApplicationController
  def index
    @user = current_user
    @shoes = Shoe.where(sold: false)
  end

  def buy_shoes
    @shoe = Shoe.find(params[:id])
    @seller = @shoe.seller
    @user = current_user
    if @seller == @user
      flash[:errors] = ["You cannot buy from yourself!"]
      redirect_to "/shoes"
    else
      if @shoe
        @shoe.sold = true
        @shoe.buyer = current_user
        @shoe.save
      end
      redirect_to "/dashboard/#{session[:user_id]}"
    end
  	
  end

  def sell_shoes
    @user = current_user
    @shoe = Shoe.new(seller:@user, name:params[:name], price:params[:price])
  	if @shoe.save
  		redirect_to "/shoes"
  	else
  		flash[:errors] = @shoe.errors.full_messages
  		redirect_to "/dashboard/#{session[:user_id]}"
  	end
  end

  def destroy
    @shoe = Shoe.find(params[:id])
  	if @shoe && @shoe.seller_id == session[:user_id]
  		@shoe.destroy
  	end
  	redirect_to "/dashboard/#{session[:user_id]}"
  end

end
