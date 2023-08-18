class Reservation < ApplicationRecord
  with_options presence: true do
    validates :check_in
    validates :check_out
    validates :person
  end

  belongs_to :user
  belongs_to :room
end
