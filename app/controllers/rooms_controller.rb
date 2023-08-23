class RoomsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :own]

  def index
    if params[:area] == ""
      params[:area] = nil
    end
    if params[:keyword] == ""
      params[:keyword] = nil
    end

    if params[:area] && params[:keyword]
      @rooms = Room.multiple_search(params[:area], params[:keyword])
    elsif params[:area]
      @rooms = Room.search_area(params[:area])
    elsif params[:keyword]
      @rooms = Room.search_keyword(params[:keyword])
    else
      @rooms = Room.all
    end
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    @room.user = current_user
    if @room.save
      redirect_to room_path(@room), notice: "ルームを登録しました"
    else
      flash.now[:notice] = "ルームの新規登録に失敗しました"
      render "new"
    end
  end

  def show
    @room = Room.find(params[:id])
    @reservation = Reservation.new
  end

  def own
    @user = current_user
  end

  def room_params
    params.require(:room).permit(:name, :introduction, :room_charge, :address, :image)
  end
end
