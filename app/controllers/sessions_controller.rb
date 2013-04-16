class SessionsController < ApplicationController
  def new
    capture_previous_page
  end

  def create
    user = login(params[:email], params[:password], params[:remember_me])
    if user && user.platform_administrator
        redirect_to '/admin', notice: "Logged in."
    elsif user
        redirect_to previous_page, notice: "Logged in."
    else
      flash.now.alert = "Email or password was invalid."
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_url, notice: "Logged out."
  end
end
