FactoryGirl.define do

  sequence :email do |n|
    "person#{n}@test.com"
  end

  factory :store do
    name "store"
    slug "slug"
    description "description"

    factory :store_with_products do

      ignore do
        products_count 5
      end

      after(:create) do | store , evaluator |
        FactoryGirl.create_list(:product, evaluator.products_count, store: store)
      end
    end
  end

  factory :category do
    store
    name "Stuff"
  end

  factory :product do
    name "product"
    description "dummy product"
    price 3.50
    retired false
    store
  end

  factory :cart do
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
