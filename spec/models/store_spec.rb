require 'spec_helper'

describe Store do

  let(:subject){Store.new(name: "name", slug: "slug")}


  it "adds a user as a manager" do
    expect {
      subject.add_manager(FactoryGirl.create(:user))
    }.to change{subject.users.count}.by(1)
  end
end
