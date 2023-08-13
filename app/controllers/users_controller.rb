class UsersController < ApplicationController
  def profile
    @user = User.find(current_user.id)
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(params[:id])
    if @user.update(params.require(:user).permit(:image, :name, :introduction))
      redirect_to profile_path, notice: "プロフィール情報を更新しました"
    else
      flash.now[:notice] = "プロフィール情報の更新に失敗しました"
      render "edit"
    end
  end

end
