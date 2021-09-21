class Admin::SectionsController < ApplicationController
  layout 'admin'
  before_action :find_admin_school
  before_action :find_admin_course
  before_action :set_admin_section, only: %i[ show edit update destroy ]

  # GET /admin/sections or /admin/sections.json
  def index
    if @admin_course.present?
      @admin_sections = @admin_course.sections.all
    else
      @admin_sections = Admin::Section.all
    end
  end

  # GET /admin/sections/1 or /admin/sections/1.json
  def show
    # contents
    contents = @admin_section.contents
    @content_list = []
    contents.order(:position).each do |content|
      if content.contentable_type == "Video"
        video = Video.find(content.contentable_id)
        content_obj = {
            "kind": content.contentable_type,
            "name": video.name,
            "title": video.title,
            "url": video.url,
            "embed_url": video.embed_url,
            "thumbnail_medium": video.thumbnail_medium,
            "duration": video.duration
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

  # GET /admin/sections/new
  def new
    @admin_section = @admin_course.sections.new
  end

  # GET /admin/sections/1/edit
  def edit
    @admin_section = @admin_course.sections.find(params[:id])
  end

  # POST /admin/sections or /admin/sections.json
  def create
    @admin_section = @admin_course.sections.new(admin_section_params)

    respond_to do |format|
      if @admin_section.save
        format.html { redirect_to admin_school_course_section_path(@admin_school,@admin_course,@admin_section), notice: "Section was successfully created." }
        format.json { render :show, status: :created, location: @admin_section }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @admin_section.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/sections/1 or /admin/sections/1.json
  def update
    respond_to do |format|
      if @admin_section.update(admin_section_params)
        format.html { redirect_to admin_school_course_section_path(@admin_school,@admin_course,@admin_section), notice: "Section was successfully updated." }
        format.json { render :show, status: :ok, location: @admin_section }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @admin_section.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/sections/1 or /admin/sections/1.json
  def destroy
    @admin_section.destroy
    respond_to do |format|
      format.html { redirect_to admin_school_course_sections_url(@admin_school,@admin_course), notice: "Section was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_section
      @admin_section = Admin::Section.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_section_params
      params.fetch(:section, {}).permit(
        :name,
        :description,
        :position_id
      )
    end

    def find_admin_school
        @admin_school = Admin::School.find( params[:school_id] )
    end

    def find_admin_course
        @admin_course = Course.find( params[:course_id] )
    end
end
