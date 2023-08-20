class Room < ApplicationRecord
  with_options presence: true do
    validates :name
    validates :introduction
    validates :room_charge
    validates :address
  end

  has_one_attached :image

  # belongs_to :user
  has_many :reservations, dependent: :destroy

  def self.multiple_search(area, keyword)
    Room.where("address LIKE ?", "%#{area}%").or(Room.where("name LIKE ?", "%#{keyword}%")).or(Room.where("introduction LIKE ?", "%#{keyword}%"))
  end

  def self.search_area(area)
    Room.where("address LIKE ?", "%#{area}%")
  end

  def self.search_keyword(keyword)
    Room.where("name LIKE ?", "%#{keyword}%").or(Room.where("introduction LIKE ?", "%#{keyword}%"))
  end
end
