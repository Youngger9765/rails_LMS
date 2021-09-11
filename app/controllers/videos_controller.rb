class VideosController < ApplicationController

    def save_log
        video_log_data = params[:video_log_data]
        video_id = video_log_data['video_id']
        puts("params=============")        
        puts(params)
        video = Video.find(video_id)
        video.active_log.save_to_db()

        return "OK!"
    end

end
