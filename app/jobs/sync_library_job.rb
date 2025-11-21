class SyncLibraryJob < ApplicationJob
  queue_as :default

  def perform(*args)
    checksums = []
    files.each do |file|
      full_path = File.join(Rails.root, 'public', 'videos', file)
      puts "Syncing file: #{file}"
      checksum = Digest::MD5.file(full_path).hexdigest
      checksums << checksum
      video = Video.find_by(checksum: checksum)
      next if video
      puts "Adding new video: #{file}"
      CreateVideoJob.perform_now(full_path, checksum)
    end
  end

  def files
    path = File.join(Rails.root, 'public', 'videos')
    @files = Dir.children(path).reject { |f| File.directory?(File.join(path, f)) }
  end
end
