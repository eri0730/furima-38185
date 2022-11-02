require 'rails_helper'

RSpec.describe OrderDestination, type: :model do
  describe '購入情報の保存' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order_destination = FactoryBot.build(:order_destination, user_id: user.id, item_id: item.id)
      sleep(1)
    end

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@order_destination).to be_valid
      end

      it 'building_nameは空でも保存できること' do
        @order_destination.building_name = ''
        expect(@order_destination).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'postal_codeが空だと保存できないこと' do
        @order_destination.postal_code = ''
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Postal code can't be blank")
      end

      it 'postal_codeが「3桁ハイフン4桁」の半角文字列でないと保存できないこと' do
        @order_destination.postal_code = '1234567'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Postal code is invalid. Enter it as follows (e.g. 123-4567)")
      end

      it 'postal_codeが全角数字だと保存できないこと' do
        @order_destination.postal_code = '１２３-４５６７'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Postal code is invalid. Enter it as follows (e.g. 123-4567)")
      end
      
      it 'prefecture_idを選択していないと保存できない' do
        @order_destination.prefecture_id = 0
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'cityが空だと保存できないこと' do
        @order_destination.city = ''
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("City can't be blank")
      end

      it 'house_numberが空だと保存できないこと' do
        @order_destination.house_number = ''
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("House number can't be blank")
      end

      it 'phone_numberが空だと保存できないこと' do
        @order_destination.phone_number = ''
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Phone number can't be blank")
      end

      it 'phone_numberが半角数値のみでないと保存できないこと' do
        @order_destination.phone_number = '031234-5678'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Phone number is invalid. Input only number")
      end

      it 'phone_numberが全角数字だと保存できないこと' do
        @order_destination.phone_number = '０９０１２３４５６７８'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Phone number is invalid. Input only number")
      end

      it 'phone_numberが10桁未満では保存できないこと' do
        @order_destination.phone_number = '090123456'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Phone number is too short")
      end

      it 'userが紐付いていないと保存できないこと' do
        @order_destination.user_id = nil
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("User can't be blank")
      end

      it 'itemが紐付いていないと保存できないこと' do
        @order_destination.item_id = nil
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
  
end
