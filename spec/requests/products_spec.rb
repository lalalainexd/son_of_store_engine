require 'spec_helper'

describe "Products" do
  describe "GET /products" do
    it "returns 200 message when logged in as admin" do
      User.create(full_name: "bob", email:"email", password:"pw", role: "admin")
      post '/session', {email:"email", password:"pw"}
      get products_path
      response.status.should be(200)
   end

    it "returns 302 access denied when not logged in" do
      get products_path
      response.status.should be(302)
    end
  end
end
