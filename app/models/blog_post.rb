class BlogPost < ActiveRecord::Base
  attr_accessible :content, :title, :user_id
  belongs_to :user
  has_many :comments

  validates :user_id, :content, presence: true
  default_scope order: 'blog_posts.created_at DESC'
end
