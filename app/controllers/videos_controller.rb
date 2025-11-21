class VideosController < ApplicationController
  def show
    @video = Video.find_by(checksum: params[:id])
  end
end
