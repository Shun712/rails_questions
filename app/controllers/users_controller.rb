class UsersController < ApplicationController
  skip_before_action :login_required, only: %i[new create]
  before_action :set_current_user, only: %i[edit destroy]

  def index
    @users = User.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to user_path(@user), notice: "ユーザー「#{@user.name}」を登録しました。"
    else
      render :new
    end
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "ユーザー「#{@user.name}」を更新しました。"
    else
      render :new
    end
  end

  def destroy
    @user.destroy!
    redirect_to user_url, notice: "ユーザー「#{@user.name}」を削除しました。"
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :nickname, :picture)
    end

    def set_current_user
      @user = current_user
    end
end
