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
      expect {
        post :create, valid_attributes
      }.to change(User, :count).by(1)
    end

    it "redirects user to root url" do
      post :create, valid_attributes
      # expect(response).to redirect_back_or_to root_url
    end
  end

  describe "POST 'create' with invalid params" do
    let(:invalid_attributes) do
      { user: {email: "", password: "password"}}
    end
  end
end
