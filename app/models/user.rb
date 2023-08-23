class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def update_without_current_password(params, *options)
    params.delete(:current_password)
    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end
    result = update(params, *options)
    clean_up_passwords
    result
  end

  has_one_attached :image

  with_options presence: true do
    validates :name
    validates :email
    validates :password, on: :create
    validates :password_confirmation, on: :create
  end

  validate :is_file_type_valid?

  def is_file_type_valid?
    return unless image.attached?

    valid_file_types = ["image/png", "image/jpg", "image/jpeg", "image/gif"]
    unless valid_file_types.include?(image.blob.content_type)
      errors.add(:image, "には拡張子が.png, .jpg, .jpeg, .gifのいずれかのファイルを添付してください")
    end
  end

  has_many :rooms, dependent: :destroy
  has_many :reservations, dependent: :destroy
end
