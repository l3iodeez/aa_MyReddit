class SessionsController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def create
    user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )

    if user
      user.reset_session_token!
      session[:session_token] = user.session_token
      redirect_to user_url(user)
    else
      @user = User.new(username: params[:user][:username])
      flash.now[:errors] = "Invalid username or password."
      render :new
    end
  end


  def destroy
    if session[:session_token]
      user = User.find_by_session_token(session[:session_token])
      user.reset_session_token!
    else
      render :new
    end
  end

end
