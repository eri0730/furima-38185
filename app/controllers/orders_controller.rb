class OrdersController < ApplicationController
  before_action :authenticate_user!, only: :index
  before_action :item_find, only: [:index, :create]
  before_action :move_to_root, only: :index

  def index
    #@item = Item.find(params[:item_id])
    @order_destination = OrderDestination.new
  end

  def create
    @order_destination = OrderDestination.new(order_params)
    if @order_destination.valid?
      @order_destination.save
      redirect_to root_path
    else
      #@item = Item.find(params[:item_id])
      render :index
    end
  end

  private

  def order_params
    params.require(:order_destination).permit(:postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number).merge(item_id: params[:item_id], user_id: current_user.id)
  end

  def item_find
    @item = Item.find(params[:item_id])
  end

  def move_to_root
    if current_user == @item.user 
     redirect_to root_path
    end  
  end  

end
