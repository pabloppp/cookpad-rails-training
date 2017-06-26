class CreateUserActivities < ActiveRecord::Migration[5.1]
  def change
    create_table :user_activities do |t|
      t.references :user, foreign_key: true
      t.string :action, null: false
      t.references :target, polymorphic: true

      t.timestamps
    end
  end
end
