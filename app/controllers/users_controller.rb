class UsersController < ApplicationController
  load_and_authorize_resource
  skip_authorize_resource :only => [ :new, :create ]

  def new
    capture_previous_page
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
      UserMailer.delay.account_confirmation(@user.email, @user.full_name)
      redirect_to(session[:referer],
                  :notice => "Successfully signed up. <a href='/edit/profile'>Edit Your Account.</a>")
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
    @user = current_user
    unless @user
      redirect_to login_path
      flash[:error] = "Please login to edit your profile."
      return
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      redirect_to profile_path, notice: 'Your profile has been successfully updated.'
    end
  end
end
