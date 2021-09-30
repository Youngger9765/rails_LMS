class Admin::SectionsController < ApplicationController
  layout 'admin'
  before_action :find_admin_school
  before_action :find_admin_course
  before_action :set_admin_section, only: %i[ show edit update destroy edit_content new_content delete_content sort]

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
            "id": content.id,
            "position": content.position,
            "kind": content.contentable_type,
            "name": video.name,
            "title": video.title,
            "url": video.url,
            "embed_url": video.embed_url,
            "thumbnail_medium": video.thumbnail_medium,
            "duration": video.duration,
            "video": video,
        }
      elsif content.contentable_type == "Powerpoint"
        ppt = Powerpoint.find(content.contentable_id)
        content_obj = {
            "id": content.id,
            "position": content.position,
            "kind": content.contentable_type,
            "name": ppt.name,
            "title": ppt.name,
            "url": ppt.url,
            "ppt": ppt,
        }
      elsif content.contentable_type == "Exercise"
        ex = Exercise.find(content.contentable_id)
        cr = ex.cover_range
        quiz_init = Quiz.where(:cover_range => cr).sample
        content_obj = {
            "id": content.id,
            "position": content.position,
            "kind": content.contentable_type,
            "name": ex.name,
            "title": ex.name,
            "cover_range": ex.cover_range,
            "ex": ex,
            "quiz_init": quiz_init,
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

  # def show_content
  #   content = Content.find(params[:content_id])
  #   @content_item = content.contentable
  #   @content_item_class_name = content.contentable.class.name
  # end

  def new_content
    content_kind = params[:content_kind]
    if content_kind == "Video"
      video = Video.create(:url => params[:url])
      content_item = video
    elsif content_kind == "Powerpoint"
      ppt = Powerpoint.create(:url => params[:url])
      content_item = ppt
    elsif content_kind == "Exercise"
      ex = Exercise.create(
				name: params[:name],
				cover_range: params[:cover_range],
        is_random: true
			)
			content_item = ex
    end
    @admin_section.contents.create(:contentable => content_item)
    
    respond_to do |format|
      format.html { redirect_to admin_school_course_section_url(@admin_school,@admin_course, @admin_section), notice: "Content was successfully updated." }
    end
  end

  def edit_content
    content_kind = params[:content_kind]
    if content_kind == "Video"
      video = Video.find(params[:video_id])
      url = params[:url]
      video.url = url
    elsif content_kind == "Powerpoint"
      ppt = Powerpoint.find(params[:ppt_id])
      url_input = params[:url]
      ppt.update_embed_url(url_input)
    end
    
    respond_to do |format|
      format.html { redirect_to admin_school_course_section_url(@admin_school,@admin_course, @admin_section), notice: "Content was successfully updated." }
    end
  end

  def delete_content
    content = Content.find(params[:content_id])
    content.destroy
    respond_to do |format|
      format.html { redirect_to admin_school_course_section_url(@admin_school,@admin_course, @admin_section), notice: "Content was successfully updated." }
    end
  end

  def quiz_content
    @modal_id = params[:modal_id]
    @ex = Exercise.find(params[:ex_id])
    cover_range = @ex.cover_range
    @quiz = Quiz.where(:cover_range => cover_range).sample
    respond_to do |format|
      format.js {
        render  :template => "admin/sections/next_quiz.js.erb",
        :layout => false
      }
    end
  end

  def summit_quiz
    @quiz_id = params[:quiz_id]
    @modal_id = params[:modal_id]
    @quiz = Quiz.find(@quiz_id)
    correct_answer = @quiz.correct_answer
    summit_ans = params[:summit_ans]
    
    respond_to do |format|
      if summit_ans == correct_answer
        format.js {
          render  :template => "admin/sections/quiz_summit.success.js.erb",
          :layout => false
        }
      else
        format.js {
          render  :template => "admin/sections/quiz_summit.error.js.erb",
          :layout => false
        }
      end
    end
  end

  def sort
      @admin_section.insert_at(params[:to].to_i + 1)
      render json: {status: "ok"}
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
        :position
      )
    end

    def find_admin_school
      if (params.has_key?(:school_id))
        @admin_school = Admin::School.find( params[:school_id] )
      end
    end

    def find_admin_course
      if(params.has_key?(:course_id))
        @admin_course = Course.find( params[:course_id] )
      end
    end
end
