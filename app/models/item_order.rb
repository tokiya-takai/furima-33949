class ItemOrder
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :place_id, :city, :address, :building, :phone_number, :order_id, :token
  
  VALIDE_POSTAL_CODE_REGEX = /\A\d{3}[-]\d{4}\z/
  VALIDE_PHONE_NUMBER_REGEX = /\A\d{1,11}\z/
  validates :postal_code, format: {with: VALIDE_POSTAL_CODE_REGEX}, allow_blank: true
  validates :phone_number, length: { maximum: 11 },format: {with: VALIDE_PHONE_NUMBER_REGEX}, allow_blank: true
  validates :place_id, numericality: { other_than: 1 ,message: ": Prefecture is not selected"}

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postal_code
    validates :city
    validates :address
    validates :phone_number
  end
  
  validates :token, presence: {message: ": Card information is incorrect" }

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(postal_code: postal_code, place_id: place_id, city: city, address: address, phone_number: phone_number, order_id: order.id)
    return true
  end
end