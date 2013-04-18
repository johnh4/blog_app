class User < ActiveRecord::Base
  attr_accessible :email, :name, :user_id
  has_many :blog_posts

  validates :email, :name, presence: true
end
