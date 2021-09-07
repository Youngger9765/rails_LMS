class StudentsController < ApplicationController
    before_action :set_student, :only => [ :show, :edit, :update, :destroy]
    before_action :find_school
    before_action :find_classroom

    def index
        @students = @school.students
    end

    def show
    end

    def new
        @student = @school.students.build
    end

    def create
        # classroom many to many
        # @student = Student.create( student_params )
        # @ship = ClassroomStudentShip.new(
        #     :student_id => @student.id,
        #     :classroom_id => @classroom.id
        # )
        @student = @school.students.create(student_params)
        if @student.present?
            redirect_to school_students_url( @school)
        else
            render :action => :new
        end
    end

    def edit
        @student = @school.students.find( params[:id] )
    end

    def update
        @student = @school.students.find( params[:id] )

        if @student.update( student_params )
            redirect_to school_students_url( @school )
        else
            render :action => :edit
        end

    end

    def destroy
        @student = @school.students.find( params[:id] )
        @student.destroy

        redirect_to school_students_url( @school)
    end

    protected

    def find_school
        if params[:school_id]
            @school = School.find( params[:school_id] )
        end
    end

    def find_classroom
        if params[:classroom_id].present?
            @classroom = Classroom.find( params[:classroom_id] )
        end
    end

    def student_params
        params.require(:student).permit(:name)
    end

    def set_student
        @student = Student.find(params[:id])
    end
end
