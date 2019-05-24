class Admin::UsersController < ApplicationController
  before_action :set_user, only: %i(show edit update destroy destroy_stop)
  before_action :authenticate_user
  before_action :user_ensure_admin_user
  before_action :admin_least_one,only: %i(update destroy)

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
    if @user.destroy
      redirect_to admin_users_path,notice:"管理者権限でユーザーを削除しました"
    end
  end

  def user_ensure_admin_user
    if current_user.admin == false
      raise Forbidden
    end
  end

  private

  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation,:admin)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def admin_least_one
    if User.where(admin: "true").count == 1  && @user.admin == true
      redirect_to admin_users_path,notice:"管理者は最低１人必要です"
    end
  end
end