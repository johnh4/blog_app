FactoryGirl.define do
  factory :user do
    name     "John Howlett"
    email    "johnhowlett@example.com"
  end

  factory :blog_post do
  	content "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas facilisis egestas scelerisque. In hac habitasse platea dictumst. Aliquam ac massa tortor, vel eleifend quam."
  	title   "Post Title"
  	user
  end
end