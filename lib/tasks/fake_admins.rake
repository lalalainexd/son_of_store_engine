# namespace :db do
#   desc "Fill database with sample admins"
#   task populate: :environment do
#     admin = User.create!(full_name: "Example User",
#                          display_name: "example@railstutorial.org",
#                          email: email
#                          password: "foobar",
#                          password_confirmation: "foobar")
#     admin.toggle!(:admin)
#     .
#     .
#     .
#   end
# end

### example text from Hartl's tutorial
### example for creating 50 blog posts per user

# namespace :db do
#   desc "Fill database with sample data"
#   task populate: :environment do
#     .
#     .
#     .
#     users = User.all(limit: 6)
#     50.times do
#       content = Faker::Lorem.sentence(5)
#       users.each { |user| user.microposts.create!(content: content) }
#     end
#   end
# end

