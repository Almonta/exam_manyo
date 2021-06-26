class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]
  before_action :current_user, only: %i[ edit update destroy ]

  def index
    @user = current_user
    @tasks = current_user.tasks
    if params[:sort_expired]
      @tasks = @tasks.order(deadline: :desc)
    elsif params[:sort_priority]
      @tasks = @tasks.order(priority: :asc)
    elsif params[:search].present? && params[:status] != ""
      @tasks = @tasks.search_task_name(params[:search]).search_status(params[:status])
    elsif params[:search].present? && params[:status] == ""
      @tasks = @tasks.search_task_name(params[:search])
    elsif params[:search] == "" && params[:status] != ""
      @tasks = @tasks.search_status(params[:status])
    else
      @tasks = @tasks.by_created_at
    end
    @tasks = @tasks.page(params[:page]).per(5)
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
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
