class SectionsController < ApplicationController
    before_action :find_school
    before_action :find_course

    def index
        @sections = @course.sections
    end

    def show
        if @course.present?
            @section = @course.sections.find( params[:id] )
        elsif @course.present?
            @section = @course.sections.find( params[:id] )
        end

        # contents
        contents = @section.contents
        @content_list = []
        contents.order(:position).each do |content|
            if content.contentable_type == "Video"
                video = Video.find(content.contentable_id)
                content_obj = {
                    "kind": content.contentable_type,
                    "name": video.name,
                    "url": video.url
                }
            elsif content.contentable_type == "Powerpoint"
                ppt = Powerpoint.find(content.contentable_id)
                content_obj = {
                    "kind": content.contentable_type,
                    "name": ppt.name,
                    "url": ppt.url
                }
            end
            @content_list << content_obj
        end
    end

    def new
        @section = @course.sections.build
    end

    def create
        # many to many
        @section = section.create( section_params )
        @ship = coursesectionShip.new(
            :section_id => @section.id,
            :course_id => @course.id
        )
        if @ship.save
            redirect_to school_course_sections_url( @school, @course )
        else
            render :action => :new
        end
    end

    def edit
        @section = @course.sections.find( params[:id] )
    end

    def update
        @section = @course.sections.find( params[:id] )

        if @section.update( section_params )
            redirect_to school_course_sections_url( @school, @course )
        else
            render :action => :edit
        end

    end

    def destroy
        @section = @course.sections.find( params[:id] )
        @section.destroy

        redirect_to school_course_sections_url( @school, @course )
    end

    protected

    def find_school
        if params[:school_id].present?
            @school = School.find( params[:school_id] )
        end
    end

    def find_course
        if params[:course_id].present?
            @course = Course.find( params[:course_id] )
        end
    end

    def section_params
        params.require(:section).permit(:name, :position_id)
    end
end
