require "spec_helper"

describe UserMailer do
  describe "order_confirmation" do

    let(:user) { User.create(full_name: "JoshMejia",
                             email: "user@oregonsale.com",
                             password: "password") }
    let(:order) { Order.create(confirmation: "AAAAAA") }
    let(:mail) { UserMailer.order_confirmation(user, order) }

    it "renders the headers" do
      mail.subject.should eq("Order confirmation")
      mail.to.should eq(["user@oregonsale.com"])
      mail.from.should eq(["no-reply@oregonsale.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("JoshMejia")
    end
  end

end
