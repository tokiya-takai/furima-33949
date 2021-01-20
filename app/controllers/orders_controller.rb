class OrdersController < ApplicationController

  def index
    @order = Order.new(order_params)
  end

  private
  def order_params
    params.permit(:item_id).merge(user_id: current_user.id)
  end
end
