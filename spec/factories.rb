FactoryGirl.define do

  sequence :email do |n|
    "person#{n}@test.com"
  end

  factory :store do
    name "store"
    slug "slug"
    description "description"
  end

  factory :user do
    full_name "John Doe"
    email
    password "password"
    password_confirmation "password"
  end

  factory :platform_admin, class: User do
    full_name "Jane Doe"
    email
    password "password"
    password_confirmation "password"
    platform_administrator true
  end

end
