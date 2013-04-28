class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :title
      t.integer :last_poster_id
      t.datetime :last_post_at

      t.timestamps
    end
  end
end
