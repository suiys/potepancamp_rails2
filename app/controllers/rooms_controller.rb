class RoomsController < ApplicationController
  def index
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    @room.user_id = current_user.id
    binding.pry
    if @room.save
      binding.pry
      redirect_to room_path(@room), notice: "ルームを登録しました"
    else
      binding.pry
      flash.now[:notice] = "ルームの新規登録に失敗しました"
      render "new"
    end
  end

  def show
    @room = Room.find(params[:id])
  end

  def edit
    
  end

  def update
    
  end

  def destroy
    
  end

  def own
    
  end

  def room_params
    params.require(:room).permit(:name, :introduction, :room_charge, :address, :image)
  end
end
