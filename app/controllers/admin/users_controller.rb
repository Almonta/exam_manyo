class Admin::UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  #いや、これでいい。管理者以外は全てのアクションに入れない
  # before_action :admin_login_required
  # before_action :admin_login_required, only: %i[ index show edit update destroy ]

  def index
    @users = User.all.includes(:tasks)
  end
  
  def show    
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: "新規ユーザを登録しました"
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "ユーザ情報を編集しました"
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: "ユーザを削除しました"
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def admin_login_required
    redirect_to tasks_path, notice: "管理者以外はadminページにアクセス出来ません" unless current_user.admin
  end
end
