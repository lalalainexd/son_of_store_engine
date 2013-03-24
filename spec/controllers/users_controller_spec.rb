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

  describe "POST 'create'" do
    let(:valid_attributes) do
      { user: { email: "user@oregonstore.com", 
        password: "password" } }
    end

    it "saves the new user to the database" do
      expect {
        post :create, valid_attributes
      }.to change(User, :count).by(1)
    end

    it "redirects user to root url" do
      expect {
        post :create, valid_attributes
      }.to redirect_to root_url
    end
  end

end
