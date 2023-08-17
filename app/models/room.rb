class Room < ApplicationRecord
  with_options presence: true do
    validates :name
    validates :introduction
    validates :room_charge
    validates :address
  end

  has_one_attached :image
end
