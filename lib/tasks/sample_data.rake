namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "Example User",
                 email: "example@johnhowlett.org",
                 password: "password",
                 password_confirmation: "password")
    5.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@johnhowlett.org"
      password = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
    users = User.all(limit: 5)
    4.times do
      content = Faker::Lorem.sentence(5)
      title = Faker::Lorem.sentence(1)
      users.each { |user| user.blog_posts.create!(content: content, title: title) }
    end
    Forum.create!(name: "Test Forum 1",
                  description: "The first test forum.")
    Forum.create!(name: "Test Forum 2",
                  description: "The second test forum.")
  end
end