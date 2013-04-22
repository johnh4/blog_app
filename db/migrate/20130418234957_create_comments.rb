class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.integer :user_id
      t.integer :blog_post_id

      t.timestamps
    end
    add_index :comments, [:blog_post_id, :created_at]
  end
end
