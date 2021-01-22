class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]
  before_action :check_sold_out

  def index
    if @item.id == current_user.id
      redirect_to root_path
    end
    @item_order = ItemOrder.new
  end

  def create
    @item_order = ItemOrder.new(item_order_params)
    if @item_order.valid?
      pay_item
      @item_order.save
      redirect_to root_path
    else
      render action: :index
    end
  end

  private
  def set_item
    @item= Item.find(params[:item_id])
  end

  def order_params
    params.permit(:item_id).merge(user_id: current_user.id)
  end

  def item_order_params
    params.require(:item_order).permit(:postal_code,:place_id,:city,:address,:building,:phone_number).merge(user_id: current_user.id, item_id: params[:item_id],token: params[:token])
  end

  def check_sold_out
    item = Item.find(params[:item_id])
    if item.order != nil
      redirect_to root_path
    end
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price, #商品の値段
      card: @item_order.token, #カードトークン
      currency: 'jpy'             #通貨の種類(日本円)
    )
  end
end
