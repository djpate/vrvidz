class Video < ApplicationRecord
  has_many :tags, through: :taggings
  has_many :previews, dependent: :destroy

  def filepath
    File.join(Rails.root, 'public', 'videos', filename)
  end
end
