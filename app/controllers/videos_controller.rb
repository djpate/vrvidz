class VideosController < ApplicationController
  def show
    @video = Video.find_by(checksum: params[:id])
  end

  def rate
    @video = Video.find_by(checksum: params[:id])
    if @video.update(rating: params[:rating])
      render json: { rating: @video.rating }
    else
      render json: { error: "Failed to update rating" }, status: 422
    end
  end
end
