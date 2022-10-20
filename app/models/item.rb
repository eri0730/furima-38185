class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :delivery_cost
  belongs_to :prefecture
  belongs_to :shipping_date

  validates :name, :description, :image, presence: true
  validates :price, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, message: "is invalid"}

  validates :category_id, :status_id, :delivery_cost_id, :shipping_date_id, numericality: {other_than: 1, message: "can't be blank"} 
  validates :prefecture_id, numericality: {other_than: 0, message: "can't be blank"} 

end
