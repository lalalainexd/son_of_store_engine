require 'spec_helper'

describe HomeController do
  describe "GET 'show'" do
    it "returns http success" do
      pending "this test will have to change since home page will be different"
      get 'show'
      response.should be_success
    end
  end

end
