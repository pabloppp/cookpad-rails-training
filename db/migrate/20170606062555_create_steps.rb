class CreateSteps < ActiveRecord::Migration[5.1]
  def change
    create_table :steps do |t|
      t.references :recipe, foreign_key: true
      t.string :description, null: false

      t.timestamps
    end
  end
end
