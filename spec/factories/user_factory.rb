FactoryGirl.define do

  sequence :email do |n|
    "person#{n}@test.com"
  end

  factory :user do
    full_name "John Doe"
    email
    password "password"
    role "user"
  end

end
