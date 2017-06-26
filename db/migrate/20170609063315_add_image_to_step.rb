class AddImageToStep < ActiveRecord::Migration[5.1]
  def up
    add_attachment :steps, :image
  end

  def down
    remove_attachment :steps, :image
  end
end
