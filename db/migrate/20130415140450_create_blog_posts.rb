class CreateBlogPosts < ActiveRecord::Migration
  def change
    create_table :blog_posts do |t|
      t.text :content
      t.string :title
      t.integer :user_id

      t.timestamps
    end
    add_index :blog_posts, [:user_id, :created_at]
  end
end
