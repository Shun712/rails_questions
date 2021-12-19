class Admin::UsersController < ApplicationController
  before_action :required_admin

  def index
    @users = User.page(params[:page]).per(10)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice: "ユーザー「#{@user.name}」を削除しました。"
  end

  private

    def required_admin
      redirect_to root_path unless current_user.admin?
    end
end
