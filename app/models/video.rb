class Video < ApplicationRecord
  has_many :tags, through: :taggings

  def filepath
    File.join(Rails.root, 'public', 'videos', filename)
  end
end
