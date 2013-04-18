namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "Example User",
                 email: "example@johnhowlett.org")
    5.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@johnhowlett.org"
      User.create!(name: name,
                   email: email)
    end
    users = User.all(limit: 5)
    4.times do
      content = Faker::Lorem.sentence(5)
      users.each { |user| user.blog_posts.create!(content: content) }
    end
  end
end