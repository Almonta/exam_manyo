module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  
  def logged_in?
    current_user.present?
  end

  # Taskに値がなく、うまくいかなかった
  # def restriction
  #   @task = Task.find_by(id: params[:id])
  #   binding.irb
  #   if @task.user.id != current_user.id
  #   redirect_to tasks_path, notice: '他人のページにはアクセス出来ません'
  #   end
  # end

end
