class SessionsController < ApplicationController

  def create
    @session = User.find_by_email(login_params[:email])
    if @session && @session.authenticate(login_params[:password])
      session[:user_id] = @session.id
      redirect_to root_path, :notice => "Logged in successfully as #{@session.name}"
    else
      flash[:error] = "Incorrect name or email"
      render 'new'
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