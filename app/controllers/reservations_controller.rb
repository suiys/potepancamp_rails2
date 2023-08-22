class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @total_charges = []
    @user.reservations.each do |reservation|
      total_charge = calc_total_room_charge(reservation)
      @total_charges << total_charge
    end
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.user = current_user
    if @reservation.save
      redirect_to reservations_path, notice: "予約を確定しました"
    else
      flash.now[:notice] = "予約の確定ができませんでした"
      render "rooms/show"
    end
  end

  def confirm
    @reservation = Reservation.new(reservation_params)
    @reservation.user = current_user
    @room = @reservation.room
    if @reservation.invalid?
      flash.now[:notice] = "予約情報に不備があります"
      render "rooms/show"
    else
      @stay_for = stay_days(@reservation)
      @total_charge = calc_total_room_charge(@reservation)
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
