require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe "商品の出品" do
    context "出品ができる場合" do
      it "image,title,content,categori_id,status_id,delivery_id,place_id,duration_id,priceが存在すれば、出品できる" do
        expect(@item).to be_valid
      end

    end
    context "出品ができない場合" do

      #いずれか一つがなければ出品できない
      it "imageがなければ出品できない" do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it "titleがなければ出品できない" do
        @item.title = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Title can't be blank")
      end
      it "contentがなければ出品できない" do
        @item.content = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Content can't be blank")
      end
      it "category_idがなければ出品できない" do
        @item.category_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Category is not a number")
      end
      it "status_idがなければ出品できない" do
        @item.status_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Status is not a number")
      end
      it "delivery_idがなければ出品できない" do
        @item.delivery_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery is not a number")
      end
      it "place_idがなければ出品できない" do
        @item.place_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Place is not a number")
      end
      it "duration_idがなければ出品できない" do
        @item.duration_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Duration is not a number")
      end
      it "priceがなければ出品できない" do
        @item.price = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it "priceが300円以下では出品できない" do
        @item.price = 100
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
      end
      it "priceが9999999以上では出品できない" do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")
      end
      it "priceが半角数字以外では出品できない" do
        @item.price = "３００"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
    end
  end
end
