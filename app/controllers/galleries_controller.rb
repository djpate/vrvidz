class GalleriesController < ApplicationController
  def show
    @videos = Video.all

    # Handle sorting
    case params[:sort]
    when 'rating'
      @videos = @videos.order(rating: :desc, created_at: :desc)
    when 'date_added'
      @videos = @videos.order(created_at: :desc)
    when 'title'
      @videos = @videos.order(:title)
    when 'duration'
      @videos = @videos.order(duration: :desc)
    else
      @videos = @videos.order(created_at: :desc) # default sort
    end
  end

  def update
    SyncLibraryJob.perform_later
    redirect_to root_path, notice: 'Video library sync started!'
  end
end
