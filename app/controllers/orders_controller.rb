class OrdersController < ApplicationController

  def index
    @item = Item.find(params[:item_id])
    @order_destination = OrderDestination.new
  end
  
end
