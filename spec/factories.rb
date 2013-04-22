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

  factory :comment do
  	content "Nulla quis sem at nibh elementum imperdiet. Duis sagittis ipsum. Praesent mauris. Fusce nec tellus sed augue semper porta. Mauri."
  	user
  	blog_post
  end


end