class Admin::CoursesController < ApplicationController
  layout 'admin'
  before_action :find_admin_school
  before_action :set_admin_course, only: %i[ show edit update destroy ]

  # GET /admin/courses or /admin/courses.json
  def index
    if @admin_school.present?
      @admin_courses = @admin_school.courses.all
    else
      @admin_courses = Admin::Course.all
    end
  end

  # GET /admin/courses/1 or /admin/courses/1.json
  def show
  end

  # GET /admin/courses/new
  def new
    @admin_course = @admin_school.courses.new
  end

  # GET /admin/courses/1/edit
  def edit
    @admin_course = @admin_school.courses.find(params[:id])
  end

  # POST /admin/courses or /admin/courses.json
  def create
    @admin_course = @admin_school.courses.new(admin_course_params)

    respond_to do |format|
      if @admin_course.save
        format.html { redirect_to admin_school_course_path(@admin_school,@admin_course), notice: "Course was successfully created." }
        format.json { render :show, status: :created, location: @admin_course }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @admin_course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/courses/1 or /admin/courses/1.json
  def update
    respond_to do |format|
      if @admin_course.update(admin_course_params)
        format.html { redirect_to admin_school_course_path(@admin_school,@admin_course), notice: "Course was successfully updated." }
        format.json { render :show, status: :ok, location: @admin_course }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @admin_course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/courses/1 or /admin/courses/1.json
  def destroy
    @admin_course.destroy
    respond_to do |format|
      format.html { redirect_to admin_school_courses_url(@admin_school), notice: "Course was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_course
      @admin_course = Admin::Course.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_course_params
      params.fetch(:course, {}).permit(
        :name,
        :description,
        :goal,
        :note,
        :tool
      )
    end

    def find_admin_school
        @admin_school = Admin::School.find( params[:school_id] )
    end
end
