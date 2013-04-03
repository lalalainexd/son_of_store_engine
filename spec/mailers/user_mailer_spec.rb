require "spec_helper"

describe UserMailer do
  describe "order_confirmation" do
    let(:mail) { UserMailer.order_confirmation }

    it "renders the headers" do
      mail.subject.should eq("Order confirmation")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
