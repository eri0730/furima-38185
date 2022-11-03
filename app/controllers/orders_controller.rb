class OrdersController < ApplicationController
  before_action :authenticate_user!, only: :index
  before_action :item_find, only: [:index, :create]
  before_action :move_to_root, only: [:index, :create]

  def index
    @order_destination = OrderDestination.new
  end

  def create
    @order_destination = OrderDestination.new(order_params)
    if @order_destination.valid?
      pay_item
      @order_destination.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:order_destination).permit(:postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number).merge(item_id: params[:item_id], user_id: current_user.id, token: params[:token])
  end

  def item_find
    @item = Item.find(params[:item_id])
  end

  def move_to_root
    if current_user == @item.user || @item.order.present?
     redirect_to root_path
    end  
  end  

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"] # テスト秘密鍵
    Payjp::Charge.create(
      amount: @item.price,  
      card: order_params[:token],  
      currency: 'jpy'          
    )
  end  

end
