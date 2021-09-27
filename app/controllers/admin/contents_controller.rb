class Admin::ContentsController < ApplicationController


    def sort
        @content = Content.find(params[:id])
        @content.insert_at(params[:to].to_i + 1)
        render json: {status: "ok"}
    end
end
