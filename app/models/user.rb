class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable
        #  :validatable
  has_many :items
  has_many :orders
  
  VALID_EMAIL_REGEX = /\A[\w\-\._]+@[\w\-\._]+\.[A-Za-z]+\z/i
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i
  JAPANESE_REGEX = /\A[ぁ-んァ-ヶ一-龥々]+\z/
  KATAKANA_REGEX = /\A[ァ-ヶー－]+\z/

  with_options presence: true do
    #ニックネームが必須であること
    validates :nickname

    #メールアドレスが必須であり、@を含んでおり、重複していないこと
    validates :email, uniqueness: { case_sensitive: true }
    validates :email, format: { with: VALID_EMAIL_REGEX }, allow_blank: true

    #パスワードが必須であり、半角英数字混合の6文字以上であること
    validates :password, format: { with: VALID_PASSWORD_REGEX }, length: {minimum: 6}, allow_blank: true
    validates :password, confirmation: true

    #名字と名前が必須であり、全角ひらがな・カタカナ・漢字であること
    validates :family_name, format: { with: JAPANESE_REGEX} , allow_blank: true
    validates :family_name

    validates :first_name, format: { with: JAPANESE_REGEX }, allow_blank: true
    validates :first_name

    #名字と名前のフリガナ必須であり、全角カタカナであること
    validates :family_name_kana, format: { with: KATAKANA_REGEX }, allow_blank: true
    validates :family_name_kana

    validates :first_name_kana, format: { with: KATAKANA_REGEX }, allow_blank: true
    validates :first_name_kana

    #生年月日が必須であること
    validates :birthday
  end
end
