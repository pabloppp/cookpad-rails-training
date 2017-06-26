class MakeUserActivitiesUseSti < ActiveRecord::Migration[5.1]
  def up
    rename_column :user_activities, :action, :type
    update <<-SQL
      UPDATE user_activities SET type = 'BookmarkActivity'
    SQL
  end

  def down
    rename_column :user_activities, :type, :action
    update <<-SQL
      UPDATE user_activities SET action = 'bookmark'
    SQL
  end
end
