class Admin::ClassroomsController < ApplicationController
  layout 'admin'
  before_action :find_admin_school
  before_action :set_admin_classroom, only: %i[ show edit update destroy add_student remove_student ]

  # GET /admin/classrooms or /admin/classrooms.json
  def index
    if @admin_school.present?
      @admin_classrooms = @admin_school.classrooms.all
    else
      @admin_classrooms = Admin::Classroom.all
    end
  end

  # GET /admin/classrooms/1 or /admin/classrooms/1.json
  def show
    @admin_students = @admin_classroom.students
    @admin_courses = @admin_classroom.courses
  end

  # GET /admin/classrooms/new
  def new
    @admin_classroom = @admin_school.classrooms.new
  end

  # GET /admin/classrooms/1/edit
  def edit
    @admin_classroom = @admin_school.classrooms.find(params[:id])
  end

  # POST /admin/classrooms or /admin/classrooms.json
  def create
    @admin_classroom = @admin_school.classrooms.new(admin_classroom_params)

    respond_to do |format|
      if @admin_classroom.save
        format.html { redirect_to admin_school_classroom_path(@admin_school,@admin_classroom), notice: "Classroom was successfully created." }
        format.json { render :show, status: :created, location: @admin_classroom }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @admin_classroom.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/classrooms/1 or /admin/classrooms/1.json
  def update
    respond_to do |format|
      if @admin_classroom.update(admin_classroom_params)
        format.html { redirect_to admin_school_classroom_path(@admin_school,@admin_classroom), notice: "Classroom was successfully updated." }
        format.json { render :show, status: :ok, location: @admin_classroom }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @admin_classroom.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/classrooms/1 or /admin/classrooms/1.json
  def destroy
    @admin_classroom.destroy
    respond_to do |format|
      format.html { redirect_to admin_school_classrooms_url(@admin_school), notice: "Classroom was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def add_student
    @admin_student = Student.find(params[:student_id])
    @admin_classroom.set_student_is_registered(@admin_student.id)
    respond_to do |format|
      format.html { redirect_to admin_school_classroom_url(@admin_school,@admin_classroom), notice: "Student is registered!" }
      format.json { head :no_content }
    end
  end

  def remove_student
    @admin_student = Student.find(params[:student_id])
    @admin_classroom.set_student_is_removed(@admin_student.id)
    respond_to do |format|
      format.html { redirect_to admin_school_classroom_url(@admin_school,@admin_classroom), notice: "Student is registered!" }
      format.json { head :no_content }
    end
  end

  def remove_course
    raise
  end

  def recover_course
    raise
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_classroom
      @admin_classroom = Admin::Classroom.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_classroom_params
      params.fetch(:classroom, {}).permit(
        :name,
        :description,
        :city,
        :school_name,
        :school_type,
        :grade
      )
    end

    def find_admin_school
        @admin_school = Admin::School.find( params[:school_id] )
    end
end
