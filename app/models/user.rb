class User < ActiveRecord::Base
  attr_accessible :email, :name

  validates :email, :name, presence: true
end
