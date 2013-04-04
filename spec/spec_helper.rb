# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require 'simplecov'
SimpleCov.start do
  add_filter '/spec'
end
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

require 'capybara/rspec'
require 'capybara/rails'
#Capybara.default_driver = :selenium


# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|  
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  # config.use_transactional_fixtures = true
  RSpec.configure do |config|

    config.include Sorcery::TestHelpers::Rails

    config.before(:suite) do
      DatabaseCleaner.clean_with(:truncation)
    end

    config.before(:each) do
      DatabaseCleaner.strategy = :transaction
    end

    config.before(:each, :js => true) do
      DatabaseCleaner.strategy = :truncation
    end

    config.before(:each) do
      DatabaseCleaner.start
    end

    config.after(:each) do
      DatabaseCleaner.clean
    end

  end

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  config.include Rails.application.routes.url_helpers
  config.include ExampleData::Projects

end

shared_context "standard test dataset" do
  let!(:c1){Category.create(name: "Grub")}
  let!(:c2){Category.create(name: "Clothing")}
  let!(:c3){Category.create(name: "Weapons")}
  let!(:c4){Category.create(name: "Tools")}
  let!(:c5){Category.create(name: "Medicine")}
  let!(:c6){Category.create(name: "Essentials")}

  let!(:p1){Product.create( name: "Rations", price: 24,
    description: "Good for one 'splorer.", category_ids: ["1"])}
  let!(:p2){Product.create( name: "Apples", price: 19,
    description: "Great for a snack!", category_ids: ["1"])}
  let!(:p3){Product.create( name: "Bacon", price: 100,
    description: "By the slab for the whole fam!", category_ids: ["1"])}
  let!(:p4){Product.create( name: "Sarsaparilla", price: 3,
    description: "Before Coke, there was sarsaparilla.", category_ids: ["1"])}
  let!(:p5){Product.create( name: "Basic Tunic", price: 75,
    description: "Plain ol' get-up for simple folk.", category_ids: ["2"])}
  let!(:p6){Product.create( name: "Kentucky Rifle", price: 250,
    description: "Good fer huntin' squirrels 'n' such.", category_ids: ["3"])}
  let!(:p7){Product.create( name: "Stone Hunting Knife", price: 98,
    description: "Good fer fur.", category_ids: ["3", "4"])}
  let!(:p8){Product.create( name: "Sleeping Bag", price: 3,
    description: "Regain staminer! Warm 'n' cozy.", category_ids: ["4"])}
  let!(:p9){Product.create( name: "Carpenter's Tools", price: 400,
    description: "Fer fixin' up der wagon in a jiff!", category_ids: ["4"])}
  let!(:p10){Product.create( name: "Medicine bag", price: 1000,
    description: "All yer fixin's in one handy sack.", category_ids: ["5"])}
  let!(:p11){Product.create( name: "Oxen", price: 4000,
    description: "Strong, durable, and more MPG than yer SUV.", category_ids: ["6"])}
  let!(:p12){Product.create( name: "Guide", price: 15000,
    description: "Well hey there, partner! I'm here to help.", category_ids: ["6"])}
  let!(:p13){Product.create( name: "Wagon", price: 15000,
    description: "Made of wood, so you know it's good.", category_ids: ["6"])}
  let!(:p14){Product.create( name: "Tombstone", price: 1000,
    description: "Cause one person always gets off'd on the Oregon Trail. Always.", category_ids: ["6"])}
end
