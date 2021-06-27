class ApplicationController < ActionController::Base
  include SessionsHelper

  before_action :login_required
  # before_action :admin_login_required

  private
  def login_required
    redirect_to new_session_path unless current_user
  end


  # def restriction
  #   redirect_to tasks_path unless current_user
  # end
end
