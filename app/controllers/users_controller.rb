class UsersController < ApplicationController
  def profile
    @user = User.find(current_user.id)
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    binding.pry
    @user = User.find(params[:id])
    binding.pry
    if @user.update(user_params)
      binding.pry
      redirect_to profile_path, notice: "プロフィール情報を更新しました"
    else
      binding.pry
      flash.now[:notice] = "プロフィール情報の更新に失敗しました"
      render "edit"
    end
  end

  def account
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :image)
  end

end
