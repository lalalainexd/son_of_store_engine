class UsersController < ApplicationController
  load_and_authorize_resource
  skip_authorize_resource :only => [ :new, :create ]

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
      auto_login(@user)
      redirect_to root_url, :notice => "Signed up"
    else
      render :new
    end
  end

  def show
    @user = current_user
    unless @user
      redirect_to root_path
      flash[:error] = "You are not permitted to view that user."
      return
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      redirect_to @user, notice: 'Product was successfully updated.'
    end
  end
end
