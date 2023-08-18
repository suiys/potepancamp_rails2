class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :image

  with_options presence: true do
    validates :name
    validates :email
    validates :password
    validates :password_confirmation
  end

  has_many :rooms, dependent: :destroy
  has_many :reservations, dependent: :destroy
end
