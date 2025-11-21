class Video < ApplicationRecord
  has_many :tags, through: :taggings
end
