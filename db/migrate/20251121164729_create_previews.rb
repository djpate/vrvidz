class CreatePreviews < ActiveRecord::Migration[8.1]
  def change
    create_table :previews do |t|
      t.references :video, null: false, foreign_key: true
      t.string :filename
      t.integer :width
      t.integer :height
      t.integer :count

      t.timestamps
    end
  end
end
