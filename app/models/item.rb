class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :delivery
  belongs_to :place
  belongs_to :duration
  
  #販売価格は300円以上9999999以下であり、半角数値のみであること
  VALID_PRICE_REGEX = /\A[0-9]+\z/
  validates :price, numericality: { greater_than_or_equal_to: 300}, allow_blank: true
  validates :price, numericality: { less_than_or_equal_to: 9999999}, allow_blank: true
  validates :price, format: { with: VALID_PRICE_REGEX }, allow_blank: true

  with_options presence: true do
    validates :image
    validates :title
    validates :content
    validates :price
  end

  with_options numericality: { other_than: 1 } do
    validates :category_id
    validates :status_id
    validates :delivery_id
    validates :place_id
    validates :duration_id
  end


end
