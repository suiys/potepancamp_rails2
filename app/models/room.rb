class Room < ApplicationRecord
  with_options presence: true do
    validates :name
    validates :introduction
    validates :room_charge
    validates :address
  end

  has_one_attached :image

  belongs_to :user
  has_many :reservations, dependent: :destroy
end
