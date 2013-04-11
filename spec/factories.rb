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

  factory :platform_admin, class: User do
    full_name "Jane Doe"
    email
    password "password"
    platform_administrator true
  end

end
