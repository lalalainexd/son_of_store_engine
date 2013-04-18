require 'spec_helper'

describe Visitor do

  it "returns it's email when printing" do
    v = Visitor.new(email: "email@email.email")

    expect(v.to_s).to eq v.email

  end
end
