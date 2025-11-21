class GeneratePreviewsJob < ApplicationJob
  queue_as :default

  def perform(video_id)
    video = Video.find(video_id)
    return unless video

    # Define preview dimensions
    preview_width = 160
    preview_height = 90
    preview_count = 20

    # Create a temporary directory for individual frames
    temp_dir = Dir.mktmpdir
    
    # Use ffmpeg to extract frames
    movie = FFMPEG::Movie.new(video.filepath)
    duration = movie.duration
    interval = duration / preview_count

    (1..preview_count).each do |i|
      time = interval * i - (interval / 2)
      movie.screenshot(File.join(temp_dir, "frame_#{i}.jpg"), { seek_time: time, resolution: "#{preview_width}x#{preview_height}" })
    end

    # Create a sprite sheet from the frames
    sprite_filename = "#{video.checksum}_preview.jpg"
    sprite_path = File.join(Rails.root, 'public', 'videos', sprite_filename)
    
    `montage #{temp_dir}/*.jpg -tile #{preview_count}x1 -geometry #{preview_width}x#{preview_height}+0+0 #{sprite_path}`

    # Clean up temporary directory
    FileUtils.remove_entry(temp_dir)

    # Create a Preview record
    video.previews.create!(
      filename: sprite_filename,
      width: preview_width * preview_count,
      height: preview_height,
      count: preview_count
    )
  end
end
