class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      flash[:error] = "A problem creating this account has occured."
      render 'new'
    end
  end

  def edit
    redirect_to root_path unless User.find(params[:id]) == current_user
    @user = User.find(params[:id])
  end

  def update
    redirect_to root_path unless User.find(params[:id]) == current_user
    @user = current_user
    @user.name = user_params[:name]
    @user.email = user_params[:email]
    @user.password = user_params[:password]
    @user.password_confirmation = user_params[:password_confirmation]
    if @user.save
      redirect_to root_path
    else
      flash[:error] = "Update Failed"
      render 'edit'
    end
  end

  def destroy
    redirect_to root_path unless User.find(params[:id]) == current_user
    @user = current_user
    @user.destroy
    session.clear
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end