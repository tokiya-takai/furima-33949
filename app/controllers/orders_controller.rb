class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]
  before_action :can_not_buy?

  def index
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

  def item_order_params
    params.require(:item_order).permit(:postal_code,:place_id,:city,:address,:building,:phone_number).merge(user_id: current_user.id, item_id: params[:item_id],token: params[:token])
  end

  def can_not_buy?
    if @item.order != nil || @item.user_id == current_user.id
      binding.pry
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
