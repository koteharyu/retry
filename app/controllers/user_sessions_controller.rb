class UserSessionsController < ApplicationController

  skip_before_action :require_login, only: %i[new create]

  def new

  end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_back_or_to root_path, success: "successfully login"
    else
      flash.now[:danger] = "please retry"
      render :new
    end
  end

  def destroy
    logout
    redirect_to login_path, success: "bey bey"
  end

end
