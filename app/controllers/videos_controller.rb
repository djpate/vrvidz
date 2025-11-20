class VideosController < ApplicationController
  def show
    @filename = Base64.strict_decode64(params[:id])
  end
end
