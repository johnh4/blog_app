class User < ActiveRecord::Base
  attr_accessible :email, :name, :user_id, :password, :password_confirmation
  has_many :blog_posts
  has_many :comments
  has_secure_password

  before_save { email.downcase! }
  before_save :create_remember_token

  validates :email, :name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, length: { minimum: 5 }
  validates :password_confirmation, presence: true

  private
  	def create_remember_token
  		self.remember_token = SecureRandom.urlsafe_base64
  	end
end
