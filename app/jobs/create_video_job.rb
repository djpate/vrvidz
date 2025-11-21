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

    GeneratePreviewsJob.perform_later(video.id)
  end
end
