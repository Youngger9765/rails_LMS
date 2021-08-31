class TeachersController < ApplicationController

    before_action :find_school
    before_action :find_classroom

    def index
        @teachers = @classroom.teachers
    end

    def show
        @teacher = @classroom.teachers.find( params[:id] )
    end

    def new
        @teacher = @classroom.teachers.build
    end

    def create
        # many to many
        @teacher = Teacher.create( teacher_params )
        @ship = ClassroomTeacherShip.new(
            :teacher_id => @teacher.id,
            :classroom_id => @classroom.id
        )
        if @ship.save
            redirect_to school_classroom_teachers_url( @school, @classroom )
        else
            render :action => :new
        end
    end

    def edit
        @teacher = @classroom.teachers.find( params[:id] )
    end

    def update
        @teacher = @classroom.teachers.find( params[:id] )

        if @teacher.update( teacher_params )
            redirect_to school_classroom_teachers_url( @school, @classroom )
        else
            render :action => :edit
        end

    end

    def destroy
        @teacher = @classroom.teachers.find( params[:id] )
        @teacher.destroy

        redirect_to school_classroom_teachers_url( @school, @classroom )
    end

    protected

    def find_school
        @school = School.find( params[:school_id] )
    end

    def find_classroom
        @classroom = Classroom.find( params[:classroom_id] )
    end

    def teacher_params
        params.require(:teacher).permit(:name)
    end

end
