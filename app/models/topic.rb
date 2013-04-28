class Topic < ActiveRecord::Base
  attr_accessible :last_post_at, :last_poster_id, :title, :forum_id
  belongs_to :forum
  belongs_to :user
  has_many :posts, dependent: :destroy
end
