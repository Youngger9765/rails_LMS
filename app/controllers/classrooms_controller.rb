class ClassroomsController < ApplicationController

    before_action :find_school
    before_action :set_classroom, only: %i[ show edit update destroy apply]

    def index
      @classrooms = @school.classrooms
    end

    def show
      @current_student = current_user.students.in_school(@school.id).first
      @ship = nil
      if @current_student
        @ship = ClassroomStudentShip.find_by(
          classroom_id: @classroom,
          student_id: @current_student
        )
      end

      # btn woarding
      if @ship.present?
        if  @ship.status == 'removed'
          @status_wording = "加入"
        elsif @ship.status == 'applied'
          @status_wording = "申請中"
        elsif @ship.status == 'registered'
          @status_wording = "已完成申請"
        end
      else
        @status_wording == '加入'
      end

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

    def apply
      @student = current_user.students.in_school(@school.id).first
      if @student
        ship = ClassroomStudentShip.find_or_create_by(classroom_id: @classroom.id, :student_id => @student.id)
        ship.update(:status => "applied")
      end

      respond_to do |format|
        format.html { redirect_to school_classroom_url(@school, @classroom), notice: "Student was applied" }
        format.json { head :no_content }
      end
    end

    protected

    def find_school
      @school = School.find( params[:school_id] )
    end

    def set_classroom
      @classroom = Classroom.find(params[:id])
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
