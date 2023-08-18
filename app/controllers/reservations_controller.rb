class ReservationsController < ApplicationController
  def index
  end

  def new
    
  end

  def create
    
  end

  def show
    
  end

  def edit

  end

  def update
    
  end

  def destroy
    
  end

  def confirm
    @reservation = Reservation.new(reservation_params)
    @stay_for = (@reservation.check_out - @reservation.check_in).to_i
    @total_charge = @reservation.room.room_charge * @stay_for * @reservation.person
    if @reservation.invalid?
      flash.now[:notice] = "予約情報に不備があります"
      render "rooms/show"
    end
  end

  def reservation_params
    params.require(:reservation).permit(:check_in, :check_out, :person, :room_id)
  end
end
