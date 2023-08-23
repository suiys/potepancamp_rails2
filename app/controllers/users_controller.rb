class UsersController < ApplicationController
  before_action :authenticate_user!

  def profile
    @user = User.find(current_user.id)
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(params[:id])
    if @user.update!(user_params)
      redirect_to profile_path, notice: "プロフィール情報を更新しました"
    end
    rescue ActiveRecord::RecordInvalid => e
      binding.pry
      flash.now[:notice] = "プロフィール情報の更新に失敗しました"
      @user.image.purge
      render "edit"
      logger.error("プロフィールの更新に失敗しました。エラーメッセージ: #{e.record.errors.full_messages}")
  end

  def account
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :image)
  end

end
