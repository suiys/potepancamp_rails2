class RoomsController < ApplicationController
  def index
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    @room.user_id = current_user.id
    if @room.save
      redirect_to room_path(@room), notice: "ルームを登録しました"
    else
      flash.now[:notice] = "ルームの新規登録に失敗しました"
      render "new"
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

  def room_params
    params.require(:room).permit(:name, :introduction, :room_charge, :address, :image)
  end
end
