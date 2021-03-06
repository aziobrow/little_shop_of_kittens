class UsersController < ApplicationController

  before_action :require_login, only: :show

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      flash[:success] = "Logged in as #{user.username}"
      redirect_to dashboard_path
    else
      flash[:danger] = "Unable to create account"
      render :new
    end
  end

  def show
    redirect_to admin_dashboard_path if admin_logged_in?
  end

private

  def user_params
    params.require(:user).permit(:name, :address, :username, :email, :password, :password_confirmation)
  end

end
