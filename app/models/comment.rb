class Comment < ActiveRecord::Base
  attr_accessible :blog_post_id, :content, :user_id
  belongs_to :user
  belongs_to :blog_post
end
