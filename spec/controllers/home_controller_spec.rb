require 'spec_helper'

describe HomeController do
  include_context "standard test dataset"

  describe "GET 'show'" do
    it "returns http success" do
      get 'show'
      response.should be_success
    end
  end

end
