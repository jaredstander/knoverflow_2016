class SessionsController < ApplicationController
  def create
    @session = User.find_by_email(params[:session][:email].downcase)
    if @session[:user_id] = @session.user_id
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
end