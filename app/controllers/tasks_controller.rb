class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]
  before_action :current_user, only: %i[ edit update destroy ]
  # skip_before_action :login_required, only: [:new, :create]

  def index
    #@tasks = Task.all.order(created_at: :desc)
    # if params[:search].present?
    #   @tasks = Task.where("task_name LIKE ?", "%#{params[:search]}%")
    # else
    #   @tasks = Task.all
    # end
    
    @tasks = current_user.tasks
    if params[:sort_expired]
      # @tasks = Task.all.order(deadline: :desc)
      @tasks = @tasks.order(deadline: :desc)
    # elsif params[:search].present? && params[:status].present?
    elsif params[:sort_priority]
      @tasks = @tasks.order(priority: :asc)
    elsif params[:search].present? && params[:status] != ""
      #ステータスを追加する前
      # @tasks = Task.where("task_name LIKE ?", "%#{params[:search]}%")
      # @tasks = Task.where("task_name LIKE ?" && "status", "%#{params[:search]}%", "%#{params[:status]}%")
      # @tasks = Task.where("task_name LIKE '%#{params[:search]}%'").where(status: params[:status])
      @tasks = @tasks.search_task_name(params[:search]).search_status(params[:status])
    elsif params[:search].present? && params[:status] == ""
      # @tasks = Task.where("task_name LIKE ?", "%#{params[:search]}%")
      @tasks = @tasks.search_task_name(params[:search])
    elsif params[:search] == "" && params[:status] != ""
      @tasks = @tasks.search_status(params[:status])
    else
      # @tasks = Task.all.order(created_at: :desc)
      @tasks = @tasks.by_created_at
    end
    @tasks = @tasks.page(params[:page]).per(5)
  end

  def show
    # @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def edit
    # @task = Task.find(params[:id])
  end

  def create
    # @task = Task.new(task_params)
    # @task.user_id = current_user.id
    @task = current_user.tasks.build(task_params)
    if params[:back]
      render :new
    else
      if @task.save
        redirect_to tasks_path, notice: "Taskを作成しました"
      else
        render :new
      end
    end
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "Taskを編集しました"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice:"Taskを削除しました"
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:task_name, :details, :deadline, :status, :priority)
  end
end
