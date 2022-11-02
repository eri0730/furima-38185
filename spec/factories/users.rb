FactoryBot.define do
  factory :user do
    nickname { 'suzuki' }
    email { Faker::Internet.free_email }
    password { 'test1234' }
    password_confirmation { password }
    last_name { '鈴木' }
    first_name { '花子' }
    last_name_kana { 'スズキ' }
    first_name_kana { 'ハナコ' }
    birthday { '1990-01-01' }
  end
end
