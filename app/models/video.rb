class Video < ApplicationRecord
    after_create :get_video_info

    def get_video_info
        url = self.url
        video = VideoInfo.new(url)
        self.is_available = video.available?
        self.provider = video.provider
        self.video_id = video.video_id
        self.title = video.title
        self.duration = video.duration
        self.thumbnail_small = video.thumbnail_small
        self.thumbnail_medium = video.thumbnail_medium
        self.thumbnail_large = video.thumbnail_large
        self.embed_url = video.embed_url
        self.embed_code = video.embed_code 
        self.save!
    end
    
end
