FactoryGirl.define do
  factory :user do
    name     "John Howlett"
    email    "johnhowlett@example.com"
    password "password"
    password_confirmation "password"
  end

  factory :blog_post do
  	content "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas facilisis egestas scelerisque. In hac habitasse platea dictumst. Aliquam ac massa tortor, vel eleifend quam."
  	title   "Post Title"
  	user
  end

  factory :comment do
  	content "Nulla quis sem at nibh elementum imperdiet. Duis sagittis ipsum. Praesent mauris. Fusce nec tellus sed augue semper porta. Mauri."
  	user
  	blog_post
  end

  factory :forum do
    name        "forum test name"
    description "forum test description"
  end

  factory :topic do
    title             "topic test title"
    last_post_at      Time.now
    user
    forum
  end

  factory :post do
    content     "post test content"
    user
    topic
  end
end