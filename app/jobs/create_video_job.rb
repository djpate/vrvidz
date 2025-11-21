class CreateVideoJob < ApplicationJob
  queue_as :default

  def perform(filepath, checksum)
    inspector = Inspector::Video.new(filepath)
    metadata = inspector.analyze

    video = Video.create!(
      title: metadata[:title],
      filename: filepath.split('/').last,
      duration: metadata[:duration],
      rating: 0,
      view_count: 0,
      checksum: checksum
    )

    generate_screenshots(video)
  end

  def generate_screenshots(video)
    10.times do |i|
      screenshot_path = File.join(Rails.root, 'public', 'screenshots', "#{video.checksum}_thumb_#{i}.png")
      timestamp = (i + 1) * (video.duration / 11)
      `ffmpeg -ss #{timestamp} -i "#{video.filepath}" -vframes 1 -q:v 2 "#{screenshot_path}"`
    end
  end
end
