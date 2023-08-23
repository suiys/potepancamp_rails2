class Reservation < ApplicationRecord
  with_options presence: true do
    validates :check_in
    validates :check_out
    validates :person
  end
  validates :person, numericality: {only_integer: true, greater_than: 0}
  validate :checkout_must_be_after_checkin

  belongs_to :user
  belongs_to :room

  def checkout_must_be_after_checkin
    if check_out.present? && check_out < check_in
      errors.add(:check_out, "はチェックインよりも後の日付を選択してください")
    end
  end
end
