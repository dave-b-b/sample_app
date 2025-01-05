class SessionsController < ApplicationController
  def new
  end

  def create
    # This is what I created on my own without the book

    # @user = User.find_by(email: params[:session][:email])
    # if @user != nil
    #   if @user.authenticate(params[:session][:password])
    #     flash[:success] = "Welcome #{@user.name}!"
    #     redirect_to @user
    #   else
    #     flash[:danger] = "Wrong password"
    #     render 'new'
    #   end
    # else
    #   flash[:danger] = "No user associated with that email"
    #   render 'new'
    # end

    # This is the solution from the book:
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      # The above line is the same as user && user.authenticate(params[:session][:password])
      reset_session
      log_in user # redirects based on the class for user
      redirect_to user
      flash.now[:success] = "Welcome, #{user.name}"
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    log_out
    redirect_to home_url, status: :see_other
  end
end
