class GalleryController < ApplicationController
  def show
    path = File.join(Rails.root, 'public', 'videos')
    @files = Dir.children(path).reject { |f| File.directory?(File.join(path, f)) }
    render :show
  end
end
