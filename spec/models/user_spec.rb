require 'spec_helper'

describe User do
  describe "field: password" do
    let(:new_user){User.new(full_name: "user",
      email: "user@oregonsale.com") }

    context "when the password matches the password confirmation" do
      it "is valid" do
        new_user.password = "password"
        new_user.password_confirmation = "password"
        expect(new_user).to be_valid
      end
    end

    context "when the password does not match the password confirmation" do
      it "is invalid" do
        new_user.password = "password"
        new_user.password_confirmation = "not_password"
        expect(new_user).to be_invalid
      end

      it "returns errors" do
        new_user.password = "password"
        new_user.password_confirmation = "not_password"
        expect(new_user).to have(1).errors_on(:password)
      end
    end
  end

  describe "field: email" do
    let(:new_user){User.new(full_name: "bob",
      password: "password",
      password_confirmation: "password") }

    context "when email entered" do
      it "is valid" do
        new_user.email = "user@oregonsale.com"
        expect(new_user).to be_valid
      end
    end

    context "when email not entered" do
      it "is not valid" do
        new_user.email = ""
        expect(new_user).to be_invalid

        new_user.email = nil
        expect(new_user).to be_invalid
      end

      it "returns errors" do
        new_user.email = ""
        expect(new_user).to have(1).errors_on(:email)
      end
    end

    context "when an email is already in database" do
      before (:each) do
        User.create(full_name: "bob", email: "someone@oregonsale.com",
          password: "pw", password_confirmation: "pw")
      end
        
      it "is invalid" do
        new_user.email = "someone@oregonsale.com"
        expect(new_user).to be_invalid
      end

      it "returns errors" do
        new_user.email = "someone@oregonsale.com"
        expect(new_user).to have(1).errors_on(:email)
      end
    end
  end
end
