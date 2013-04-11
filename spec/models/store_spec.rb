require 'spec_helper'

describe Store do

  let(:subject){Store.new(name: "name", slug: "slug")}


  context "add a manger to a store" do
    it "adds a user as a admin" do
      Role.create(title: "admin")
      user = FactoryGirl.create(:user)
      subject.add_admin(user)
      user_store = subject.user_stores.find_by_user_id(user.id)
      expect(user_store.role.title).to eq "admin"
    end
  end

  it "returns the slug as the param" do
    expect(subject.to_param).to eq "slug"
  end
end
