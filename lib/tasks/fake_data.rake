namespace :db do
  desc "Fill database with fake stores"
  task populate: :environment do
    stores = Store.all
    10.times do |s|
      stores << Store.create!(description: Faker::Lorem.sentence,
                    name: Faker::Lorem.word.capitalize + (" ") + Faker::Lorem.word.capitalize,
                    slug: "random-url-#{s+1}",
                    status: "status"
                    )
    end

    # creates fake categories for each store
    10.times do |c|
      stores.each do |store|
        store.categories.create!(name: Faker::Lorem.word.capitalize)
      end
    end

    # creates fake products for each store
    10_000.times do |p|
      retired = "retired"
      stores.each {|store| store.products.create!(description: Faker::Lorem.sentence,
                                                  name: Faker::Lorem.word.capitalize,
                                                  price: 300000 + Random.rand(100000),
                                                  #category_ids: [store.category_ids.sample],
                                                  category_ids: store.categories.sample.id,
                                                  retired: retired,
                                                  image_name: 1 + rand(110)
                                                  )}
    end


    # creates fake admins and fake stockers for each store
    stores.each do |store|
      2.times do |i|
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

      2.times do |i|
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
    end
  end

  desc "Fill database with fake users"
  task populate: :environment do
    10_000.times do |u|
      first_name = Faker::Name.first_name
      last_name = Faker::Name.last_name
      user = User.create!(full_name: "#{first_name} #{last_name}",
                   display_name: "#{first_name[0]}#{last_name}",
                   email: "example-#{u+1}@epicsale.com",
                   password: "password",
                   password_confirmation: "password",
                   platform_administrator: false,
                   role: ["stocker", "admin", nil].sample
                  )
    end
  end


end

