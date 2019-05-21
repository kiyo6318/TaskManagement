class UsersController < ApplicationController
  before_action :set_user,only: %i(show user_ensure_correct_user)
  before_action :authenticate_user,only: %i(show)
  before_action :user_ensure_correct_user,only: %i(show)
  def new
    if logget_in?
      redirect_to user_path(current_user.id),notice: "ログインしています"
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id),notice: "ユーザー登録完了しました！ログインしています"
    else
      render "new"
    end
  end

  def show
  end

  def user_ensure_correct_user
    if @user.id != current_user.id
      redirect_to user_path(current_user.id),notice: "権限がありません"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end
end