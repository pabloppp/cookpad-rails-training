class CreateFeedItems < ActiveRecord::Migration[5.1]
  def change
    create_table :feed_items do |t|
      t.references :user, foreign_key: true
      t.references :user_activity, foreign_key: true

      t.timestamps
    end

    add_index :feed_items, [:user_id, :user_activity_id], unique: true
  end
end
