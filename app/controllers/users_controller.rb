class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user.role = :user unless @user.role
    if @user.email
      @user.display_name = @user.full_name unless @user.display_name
    end

    if @user.save
      redirect_to root_url, :notice => "Signed up"
    else
      render :new
    end
  end
end
