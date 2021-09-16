module LearningMode
  class VideoInterface
    attr_reader :video

    def initialize(video)
      @video = video
    end

    def save_log_to_db()
      puts("!!!!!!!!save_to_db!!!!!")
    end
  end
end