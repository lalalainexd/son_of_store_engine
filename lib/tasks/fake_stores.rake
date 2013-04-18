namespace :db do
  desc "Fill database with fake stores"
  task populate: :environment do

    stores = Store.all
    10.times do |s|
      stores << Store.create!(description: Faker::Lorem.sentence,
                    # name: ('a'..'z').to_a.shuffle[0,rand(3..10)].join.capitalize,
                    name: Faker::Lorem.word.capitalize + (" ") + Faker::Lorem.word.capitalize,
                    slug: "random-url-#{s+1}.com",
                    status: "status"
                    )
    end

    # creates 3 fake products for each store
    # stores = Store.all
    3.times do |p|
      description = Faker::Lorem.sentence
      name = Faker::Lorem.word.capitalize
      # price = number_to_currency(123456)
      # image = "image"
      category_ids = Category.all.sample(rand(1..4))
      retired = "retired"
      stores.each {|store| store.products.create!(description: description,
                                                  name: name,
                                                  # price: price,
                                                  category_ids: [store.category_ids.sample],
                                                  retired: retired
                                                  )}
    end

    # creates 3 fake categories for each store
    12.times do |c|
      name = Faker::Lorem.word.capitalize
      stores.each do |store|
        store.categories.create!(name: name)
        puts "Category #{name} created for Store #{store.name}"
      end
    end

    # creates 3 fake admins for each store
    stores.each do |store|
      3.times do |i|
        begin
          user = User.create!(full_name: Faker::Name.first_name,
                              password: "password",
                              email: "#{rand(100000).to_s}@epicsale.com"
                             )
          store.add_admin(user)
        rescue
          puts "email taken! retrying."
          retry
        end
      end
      puts "admin added"

      3.times do |i|
        begin
          user = User.create!(full_name: Faker::Name.first_name,
                              password: "password",
                              email: "#{rand(100000).to_s}@epicsale.com"
                             )
          store.add_stocker(user)
        rescue
          puts "email taken! retrying."
          retry
        end
      end
      puts "stocker added"
    end
  end

  desc "Fill database with fake users"
  task populate: :environment do
    9.times do |u|
      user = User.create!(full_name: Faker::Name.first_name + " " + Faker::Name.last_name,
                   # display_name: Faker::Name.first_name
                   email: "example-#{u+1}@epicsale.com",
                   password: "password",
                   password_confirmation: "password",
                   platform_administrator: false,
                   role: ["stocker", "admin", nil].sample
                  )
      puts "User #{user} created"
    end
  end


end

