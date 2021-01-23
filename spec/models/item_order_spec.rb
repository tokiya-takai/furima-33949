require 'rails_helper'

RSpec.describe ItemOrder, type: :model do
  before do
    @item = FactoryBot.create(:item)
    @item_order = FactoryBot.build(:item_order, user_id: @item.user_id, item_id: @item.id)
    sleep 0.1 #処理過多による負荷軽減
  end

  describe "商品の購入" do
    context "商品が購入できるとき" do
      it "user_id,item_id,postal_code,place_id,city,address,phone_number,tokenがあれば登録できる" do
        expect(@item_order).to be_valid
      end
      it "buildingがなくても購入できる" do
        @item_order.building = ""
        expect(@item_order).to be_valid
      end
      it "phone_numberが1桁以上11桁以下なら保存できる" do
        @item_order.phone_number = "1"
        expect(@item_order).to be_valid
      end
    end
    context "商品の購入ができないとき" do
      it "user_idがなければ購入できない" do
        @item_order.user_id = nil
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include("User can't be blank")
      end
      it "item_idがなければ購入できない" do
        @item_order.item_id = nil
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include("Item can't be blank")
      end
      it "postal_codeがなければ購入できない" do
        @item_order.postal_code = ""
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include("Postal code can't be blank")
      end
      it "cityがなければ購入できない" do
        @item_order.city = ""
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include("City can't be blank")
      end
      it "addressがなければ購入できない" do
        @item_order.address = ""
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include("Address can't be blank")
      end
      it "phone_numberがなければ購入できない" do
        @item_order.phone_number = ""
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include("Phone number can't be blank")
      end
      it "tokenがなければ購入できない" do
        @item_order.token = ""
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include("Token : Card information is incorrect")
      end
      it "place_idが1だと購入できない" do
        @item_order.place_id = 1
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include("Place : Prefecture is not selected")
      end

      it "postal_codeはハイフンが入っていないと購入できない" do
        @item_order.postal_code = "0001234"
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include("Postal code is invalid")
      end
      it "phone_numberは12桁以上では購入できない" do
        @item_order.phone_number = "000111222333"
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include("Phone number is too long (maximum is 11 characters)")
      end
      it "phone_numberは全角では購入できない" do
        @item_order.phone_number = "０００１１１２２２３３３"
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include("Phone number is invalid")
      end
      it "phone_numberは半角英数では購入できない" do
        @item_order.phone_number = "abcd"
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include("Phone number is invalid")
      end
    end
  end
end
