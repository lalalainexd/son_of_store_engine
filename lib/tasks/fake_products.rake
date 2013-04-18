# namespace :db do
#   desc "Fill database with fake stores"
#   task populate: :environment do
#     # Product.create!(full_name: "Example User",
#     #              email: "example@railstutorial.org",
#     #              password: "foobar",
#     #              password_confirmation: "foobar")
#     9.times do |n|
#       description = Faker::Lorem.sentence
#       name = Faker::Lorem.word.reverse
#       slug = "random-url-#{n+1}.com"
#       status = "status"
#       Store.create!(description: description,
#                     name: name,
#                     slug: slug,
#                     status: status)
#     end

#     Store.create!(description: "A great store for many reasons...",
#                       name: "Name of Store",
#                       slug: "store-slug",
#                       status: "store-status")
#     9.times do |n|
#       # name  = Faker::Name.name
#       description = Faker::Lorem.sentence
#       name = Faker::Lorem.word.capitalize
#       price = Faker::Base.numerify("12345")
#       # image = "image"
#       # category = Faker::Lorem.word
#       retired = "retired"
#       Product.create!(description: description,
#                    name: name,
#                    price: price,
#                    # image: image,
#                    # category: category,
#                    retired: retired)
#     end
#   end
# end
