class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params) # Not the final implementation
    if @user.save
      flash[:success] = 'Welcome to the Sample App!'
      # This is the same as redirect_to user_url(@user)
      # Rails automatically redirects to user_url
      # based on the class of the object pass to the redirect_to function
      redirect_to @user
    else
      render 'new', status: :unprocessable_entity
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end