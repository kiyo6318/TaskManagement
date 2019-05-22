class Admin::UsersController < ApplicationController
  before_action :set_user, only: %i(show edit update destroy)

  def index
    @users = User.all.includes(:tasks)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_user_path(@user.id),notice: "管理者権限でユーザー登録しました！"
    else
      render "new"
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_user_path(@user.id),notice: "管理者権限でユーザー情報を編集しました！"
    else
      render "edit"
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path,notice:"管理者権限でユーザーを削除しました"
  end

  private

  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end
end