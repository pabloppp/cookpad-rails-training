class AddUniqueIndexToUserActivities < ActiveRecord::Migration[5.1]
  def change
    add_index :user_activities, [:user_id, :type, :target_type, :target_id],
              unique: true, name: "index_user_activities_on_type_and_target"
  end
end
