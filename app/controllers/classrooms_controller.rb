class ClassroomsController < ApplicationController

    before_action :find_school

    def index
        @classrooms = @school.classrooms
    end

    def show
        @classroom = @school.classrooms.find( params[:id] )
        @teachers = @classroom.teachers
        @courses = @classroom.courses
    end

    def new
        @classroom = @school.classrooms.build
    end

    def create
        @classroom = @school.classrooms.build( classroom_params )
        if @classroom.save
            redirect_to school_classrooms_url( @school )
        else
            render :action => :new
        end
    end

    def edit
        @classroom = @school.classrooms.find( params[:id] )
    end

    def update
        @classroom = @school.classrooms.find( params[:id] )

        if @classroom.update( classroom_params )
            redirect_to school_classrooms_url( @school )
        else
            render :action => :edit
        end

    end

    def destroy
        @classroom = @school.classrooms.find( params[:id] )
        @classroom.destroy

        redirect_to school_classrooms_url( @school )
    end

    protected

    def find_school
        @school = School.find( params[:school_id] )
    end

    def classroom_params
        params.require(:classroom).permit(
            :name, 
            :description,
            :city,
            :school_name,
            :school_type,
            :grade
        )
    end

end
