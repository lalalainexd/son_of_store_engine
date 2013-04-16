require 'spec_helper'

describe Admin::DashboardController do

  describe "GET 'show'" do
    it "returns http success" do
      get 'show'
      response.should be_success
    end
  end

end
