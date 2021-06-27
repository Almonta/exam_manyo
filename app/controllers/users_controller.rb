class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  before_action :restriction, only: [:show]

  def show
    @user = User.find(params[:id])
    @tasks = current_user.tasks
    # @task = Task.find_by(id: params[:id])
    # binding.irb
    # redirect_to tasks_path unless params[:id].to_i == current_user.id
    # flash[:notice] = '他人の詳細ページには飛べません'
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def restriction
    # flash[:notice] = '他人の詳細ページには飛べません'
    if params[:id].to_i != current_user.id
      # redirect_to tasks_path
      # flash[:notice] = '他人の詳細ページには飛べません'
      redirect_to tasks_path, notice: '他人の詳細ページには飛べません'
    # redirect_to tasks_path unless params[:id].to_i == current_user.id
    end
  end
end
