class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders, dependent: :destroy
  has_many :destinations, dependent: :destroy
  has_many :cart_products, dependent: :destroy


  validates :first_name, :last_name, :first_name_kana, :last_name_kana,
            :address, :telephone_number, :postal_code, presence: true

  validates :postal_code, numericality: { only_integer: true }, format: {with:/\A\d{7}\z/, message:"7文字での入力をお願いします"}
  validates :telephone_number, numericality: { only_integer: true }
  validates :first_name_kana, :last_name_kana,  format: {with:/\A[ァ-ヶー－]+\z/, message: "全角カタカナで入力してください"}


end
