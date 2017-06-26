class AddFollowersCountToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :followers_count, :integer, null: false, default: 0
    add_column :users, :followed_users_count, :integer, null: false, default: 0
  end
end
