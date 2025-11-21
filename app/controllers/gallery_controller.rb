class GalleryController < ApplicationController
  def show
    @videos = Video.all
  end
end
