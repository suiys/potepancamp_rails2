class Room < ApplicationRecord
  with_options presence: true do
    validates :name
    validates :introduction
    validates :room_charge
    validates :address
  end

  has_one_attached :image

  validate :is_file_type_valid?

  def is_file_type_valid?
    return unless image.attached?

    valid_file_types = ["image/png", "image/jpg", "image/jpeg", "image/gif"]
    unless valid_file_types.include?(image.blob.content_type)
      errors.add(:image, "には拡張子が.png, .jpg, .jpeg, .gifのいずれかのファイルを添付してください")
    end
  end

  belongs_to :user
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
