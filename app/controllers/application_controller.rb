class ApplicationController < ActionController::Base
  include SessionsHelper

  before_action :login_required
  # before_action :admin_login_required

  private
  def login_required
    redirect_to new_session_path unless current_user
  end

  # def admin_login_required
  #   redirect_to tasks_path, notice: "管理者以外はadminページにアクセス出来ません" unless current_user.admin
  # end
end
