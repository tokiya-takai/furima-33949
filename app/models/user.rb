class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[\d])\w{6,12}\z/
  JAPANESE_REGEX = /\A[ぁ-んァ-ヶ一-龥々]+\z/
  KATAKANA_REGEX = /\A[ァ-ヶー－]+\z/

  #ニックネームが必須であること
  validates :nickname, presence: true
  #パスワードは半角英数字混合の6文字以上であること
  validates :password, format: { with: VALID_PASSWORD_REGEX }, length: {minimum: 6}

  #名字と名前が必須であり、全角ひらがな・カタカナ・漢字であること
  validates :family_name, format: {with: JAPANESE_REGEX}, allow_blank: true
  validates :family_name, presence: true

  validates :first_name, format: {with: JAPANESE_REGEX}, allow_blank: true
  validates :first_name, presence: true

  #名字と名前のフリガナ必須であり、全角カタカナであること
  validates :family_name_kana, format: {with: KATAKANA_REGEX}, allow_blank: true
  validates :family_name_kana, presence: true

  validates :first_name_kana, format: {with: KATAKANA_REGEX}, allow_blank: true
  validates :first_name_kana, presence: true

  #生年月日が必須であること
  validates :birthday, presence: true

end
