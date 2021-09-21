class Admin::SchoolsController < ApplicationController
  layout 'admin'
  before_action :set_admin_school, only: %i[ show edit update destroy ]

  # GET /admin/schools or /admin/schools.json
  def index
    @admin_schools = Admin::School.all
  end

  # GET /admin/schools/1 or /admin/schools/1.json
  def show
    @admin_classrooms = @admin_school.classrooms
  end

  # GET /admin/schools/new
  def new
    @admin_school = Admin::School.new
  end

  # GET /admin/schools/1/edit
  def edit
  end

  # POST /admin/schools or /admin/schools.json
  def create
    @admin_school = Admin::School.new(admin_school_params)

    respond_to do |format|
      if @admin_school.save
        format.html { redirect_to @admin_school, notice: "School was successfully created." }
        format.json { render :show, status: :created, location: @admin_school }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @admin_school.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/schools/1 or /admin/schools/1.json
  def update
    respond_to do |format|
      if @admin_school.update(admin_school_params)
        format.html { redirect_to @admin_school, notice: "School was successfully updated." }
        format.json { render :show, status: :ok, location: @admin_school }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @admin_school.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/schools/1 or /admin/schools/1.json
  def destroy
    @admin_school.destroy
    respond_to do |format|
      format.html { redirect_to admin_schools_url, notice: "School was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_school
      @admin_school = Admin::School.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_school_params
      params.fetch(:admin_school, {})
    end
end
