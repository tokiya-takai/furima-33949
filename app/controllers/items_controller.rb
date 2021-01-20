class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :get_an_instance, only: [:show, :edit, :update, :destroy]

  def index
    @items = Item.includes(:user).order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
    unless @item.user_id == current_user.id
      redirect_to root_path
    end
  end

  def update
    if @item.update(item_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    unless @item.user_id == current_user.id
      redirect_to root_path
    end
    @item.destroy
    redirect_to root_path
  end

  private
  def item_params
    params.require(:item).permit(:image,:title,:content,:category_id,:status_id,:delivery_id,:place_id,:duration_id,:price).merge(user_id: current_user.id)
  end

  def get_an_instance
    @item = Item.find(params[:id])
  end
end
