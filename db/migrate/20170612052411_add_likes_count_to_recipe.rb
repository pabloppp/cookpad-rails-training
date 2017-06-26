class AddLikesCountToRecipe < ActiveRecord::Migration[5.1]
  def change
    add_column :recipes, :likes_count, :integer, null: false, default: 0
  end
end
