require 'spec_helper'

describe UsersController do

  describe "GET 'new'" do
    it "renders new view" do
      get :new
      response.should be_success
      expect(response).to render_template :new
    end

    it "assigns new user to @user" do
      get :new
      expect(assigns(:user)).to be_kind_of(User)
    end
  end

  describe "POST 'create' with valid params" do
    let(:valid_attributes) do
      { user: { full_name: "name", email: "user@oregonstore.com",
        password: "password", password_confirmation: "password" } }
    end

    it "saves the new user to the database" do
      session[:referer] = root_path
      delay = stub(:delay)
      delay.should_receive(:account_confirmation).with("user@oregonstore.com", "name")
      UserMailer.should_receive(:delay).and_return(delay)

      user = User.new(full_name: "name", email: "user@oregonstore.com")
      user.should_receive(:save).and_return(true)
      User.should_receive(:new).and_return(user)
      post :create, valid_attributes
      expect(response).to redirect_to root_path
    end

  end

  describe "POST 'create' with invalid params" do
    it "saves the new user to the database" do
      user = User.new
      user.should_receive(:save).and_return(false)
      User.should_receive(:new).and_return(user)
      post :create
      expect(response).to render_template(:new)
    end
  end
end
