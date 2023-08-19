class ReservationsController < ApplicationController
  def index
    @reservations = Reservation.where(user_id: current_user.id)
    @total_charges = []
    @reservations.each do |reservation|
      total_charge = calc_total_room_charge(reservation)
      @total_charges << total_charge
    end
  end

  def new
    
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.user_id = current_user.id
    if @reservation.save
      redirect_to reservations_path, notice: "予約を確定しました"
    else
      flash.now[:notice] = "予約の確定ができませんでした"
      render "rooms/show"
    end
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
    @stay_for = stay_days(@reservation)
    @total_charge = calc_total_room_charge(@reservation)
    if @reservation.invalid?
      flash.now[:notice] = "予約情報に不備があります"
      render "rooms/show"
    end
  end

  def reservation_params
    params.require(:reservation).permit(:check_in, :check_out, :person, :room_id)
  end

  def stay_days(obj)
    (obj.check_out - obj.check_in).to_i
  end

  def calc_total_room_charge(obj)
    stay_for = stay_days(obj)
    obj.room.room_charge * stay_for * obj.person
  end
end
