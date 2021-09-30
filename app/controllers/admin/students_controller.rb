class Admin::StudentsController < ApplicationController
  before_action :find_admin_school
  before_action :find_admin_classroom
  before_action :set_admin_student, only: %i[ show edit update destroy ]

  # GET /admin/students or /admin/students.json
  def index
    @admin_students = Admin::Student.all
    if @admin_classroom.present?
      @admin_students = @admin_classroom.students
    end
    
  end

  # GET /admin/students/1 or /admin/students/1.json
  def show
  end

  # GET /admin/students/new
  def new
    @admin_student = Admin::Student.new
  end

  # GET /admin/students/1/edit
  def edit
  end

  # POST /admin/students or /admin/students.json
  def create
    @admin_student = Admin::Student.new(admin_student_params)

    respond_to do |format|
      if @admin_student.save
        format.html { redirect_to @admin_student, notice: "Student was successfully created." }
        format.json { render :show, status: :created, location: @admin_student }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @admin_student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/students/1 or /admin/students/1.json
  def update
    respond_to do |format|
      if @admin_student.update(admin_student_params)
        format.html { redirect_to @admin_student, notice: "Student was successfully updated." }
        format.json { render :show, status: :ok, location: @admin_student }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @admin_student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/students/1 or /admin/students/1.json
  def destroy
    @admin_student.destroy
    respond_to do |format|
      format.html { redirect_to admin_students_url, notice: "Student was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_student
      @admin_student = Admin::Student.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_student_params
      params.fetch(:admin_student, {})
    end

    def find_admin_school
      if (params.has_key?(:school_id))
        @admin_school = Admin::School.find( params[:school_id] )
      end
    end

    def find_admin_classroom
      if(params.has_key?(:classroom_id))
        @admin_classroom = Classroom.find( params[:classroom_id] )
      end
    end
end
