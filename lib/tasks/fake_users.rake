# namespace :db do
#   desc "Fill database with fake users"
#   task populate: :environment do
#     # User.create!(full_name: "Example User",
#     #              email: "example@railstutorial.org",
#     #              password: "foobar",
#     #              password_confirmation: "foobar")
#     9.times do |n|
#       full_name = Faker::Name.name
#       display_name = full_name
#       email = "example-#{n+1}@epicsale.com"
#         # email = Faker::Internet.email
#       password  = "password"
#       platform_administrator = "platform_administrator"
#         # this needs to change
#       role = "role"
#         # this needs to change
#       User.create!(full_name: full_name,
#                    display_name: display_name,
#                    email: email,
#                    password: password,
#                    password_confirmation: password,
#                    platform_administrator: platform_administrator,
#                    role: role)
#     end
#   end
# end
