class AddImageToRecipe < ActiveRecord::Migration[5.1]
  def up
    add_attachment :recipes, :image
  end

  def down
    remove_attachment :recipes, :image
  end
end
