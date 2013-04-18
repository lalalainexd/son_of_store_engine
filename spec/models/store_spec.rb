require 'spec_helper'

describe Store do

  let(:subject){FactoryGirl.create(:store)}

  context "getting users" do
      let(:user1) { FactoryGirl.create(:user)}
      let(:user2) {FactoryGirl.create(:user)}

     before do
      UserStore.create!(user_id: user1.id, store_id:subject.id, role_id:Role.admin.id)
      UserStore.create!(user_id: user2.id, store_id:subject.id, role_id:Role.stocker.id)

     end

     it "returns an admin" do
       expect(subject.admin(user1.id)).to eq user1
     end

     it "returns nil for an admin that doesnt exist" do
       expect(subject.admin(user2.id)).to eq nil
     end

     it "returns nil for a stocker that doesnt exist" do
       expect(subject.stocker(user1.id)).to eq nil
     end

     it "returns a stocker" do
       expect(subject.stocker(user2.id)).to eq user2
     end

    it "returns a collection of users who are admins" do
      expect(subject.admins).to include(user1)
      expect(subject.admins).to_not include(user2)
    end

    it "returns a collection of users who are stockers" do

      expect(subject.admins).to include(user1)
      expect(subject.admins).to_not include(user2)
    end
  end

  context "add an admin to a store" do
    it "adds a user as a admin" do
      user = FactoryGirl.create(:user)
      subject.add_admin(user)
      user_store = subject.user_stores.find_by_user_id(user.id)
      expect(user_store.role).to be_admin
    end
  end

  context "add a stocker to a store" do
    it "adds a user as a admin" do
      user = FactoryGirl.create(:user)
      subject.add_stocker(user)
      user_store = subject.user_stores.find_by_user_id(user.id)
      expect(user_store.role).to be_stocker
    end
  end

  context "remove an admin from a store" do
    it "removes an admin from a store" do
      user = FactoryGirl.create(:user)
      subject.add_admin(user)
      subject.remove_admin(user)
      expect(subject.admins).to_not include(user)
    end
  end

  it "returns the slug as the param" do
    expect(subject.to_param).to eq "slug"
  end

  it "can be disabpled" do
    subject.disable_status
    expect(subject).to be_disabled
  end

end
