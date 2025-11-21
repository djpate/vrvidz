class CreateVideos < ActiveRecord::Migration[8.1]
  def change
    create_table :videos do |t|
      t.string :string
      t.integer :duration
      t.integer :rating
      t.integer :view_count
      t.timestamps
    end

    create_table :tags do |t|
      t.string :name
      t.timestamps
    end

    create_table :taggings do |t|
      t.references :video, foreign_key: true
      t.references :tag, foreign_key: true
      t.timestamps
    end
  end
end
