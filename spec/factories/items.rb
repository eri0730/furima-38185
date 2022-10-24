FactoryBot.define do
  factory :item do
    name { '商品名' }
    description { '出品する商品の説明' }
    category_id { 2 }
    status_id { 2 }
    delivery_cost_id { 2 }
    prefecture_id { 2 }
    shipping_date_id { 2 }
    price { 2000 }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
