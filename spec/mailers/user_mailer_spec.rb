require "spec_helper"

describe UserMailer do
  describe "order_confirmation" do

    let(:user) { User.create(full_name: "JoshMejia",
                             email: "user@epicsale.com",
                             password: "password") }
    let(:order) { Order.create(confirmation: "AAAAAA") }
    let(:mail) { UserMailer.order_confirmation(user, order) }

    it "renders the headers" do
      mail.subject.should eq("Order confirmation")
      mail.to.should eq(["user@epicsale.com"])
      mail.from.should eq(["no-reply@epicsale.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("JoshMejia")
    end
  end

end
