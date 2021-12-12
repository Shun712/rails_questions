class Admin::UsersController < ApplicationController
  before_action :required_admin

  def index
    @users = User.all
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_user_url, notice: "ユーザー「#{@user.name}」を削除しました。"
  end

  private

    def required_admin
      redirect_to root_path unless current_user.admin?
    end
end
