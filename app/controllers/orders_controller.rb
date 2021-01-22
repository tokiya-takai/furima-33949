class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_sold_out

  def index
    @order = Order.new(order_params)
    if @order.item_id == current_user.id
      redirect_to root_path
    end
    @buy = Buy.new
  end

  def create
    binding.pry
    @buy = Buy.new(buy_params)
    if @buy.valid?
      @buy.save
      redirect_to root_path
    else
      @order = Order.new(order_params)
      render action: :index
    end
  end

  private
  def order_params
    params.permit(:item_id).merge(user_id: current_user.id)
  end

  def buy_params
    params.require(:buy).permit(:postal_code,:place_id,:city,:address,:building,:phone_number).merge(user_id: current_user.id, item_id: params[:item_id],token: params[:token])
  end

  def check_sold_out
    item = Item.find(params[:item_id])
    if item.sale == false
      redirect_to root_path
    end
  end
end
