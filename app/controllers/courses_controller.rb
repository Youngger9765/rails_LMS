class CoursesController < ApplicationController
    before_action :find_school

    def index
        @courses = @school.courses
    end

    def show
        @course = @school.courses.find( params[:id] )
    end

    def new
        @course = @school.courses.build
    end

    def create
        @course = @school.courses.build( course_params )
        if @course.save
            redirect_to school_courses_url( @school )
        else
            render :action => :new
        end
    end

    def edit
        @course = @school.courses.find( params[:id] )
    end

    def update
        @course = @school.courses.find( params[:id] )

        if @course.update( course_params )
            redirect_to school_courses_url( @school )
        else
            render :action => :edit
        end

    end

    def destroy
        @course = @school.courses.find( params[:id] )
        @course.destroy

        redirect_to school_courses_url( @school )
    end

    protected

    def find_school
        @school = School.find( params[:school_id] )
    end

    def course_params
        params.require(:course).permit(
            :name, 
            :description,
            :goal,
            :note,
            :tool
        )
    end
end
