class User < ActiveRecord::Base
  attr_accessible :email, :name, :user_id, :password, :password_confirmation
  has_many :blog_posts
  has_many :comments
  has_secure_password

  before_save { email.downcase! }

  validates :email, :name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, length: { minimum: 5 }
  validates :password_confirmation, presence: true
end
