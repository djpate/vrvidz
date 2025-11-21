module Inspector
  class Video
    def initialize(filepath)
      @filepath = filepath
    end

    def analyze
      {
        title: @filepath.split('/').last,
        duration: extract_duration,
      }
    end

    private

    def extract_duration
      `ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "#{@filepath}"`.to_i
    end
  end
end