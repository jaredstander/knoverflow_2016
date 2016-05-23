class SessionsController < ApplicationController

  def create
    user = User.find_by_email(login_params[:email])
    if user && user.authenticate(login_params[:password])
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    session.clear
    redirect_to root_path, :notice => "Logged out successfully!"
  end

  private

  def login_params
    params.require(:session).permit(:email, :password)
  end
end