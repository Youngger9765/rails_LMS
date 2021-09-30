class SectionsController < ApplicationController
  before_action :find_school
  before_action :find_course

  def index
      @sections = @course.sections
  end

  def show
    if @course.present?
      @section = @course.sections.find( params[:id] )
    elsif @course.present?
      @section = @course.sections.find( params[:id] )
    end

    # contents
    contents = @section.contents
    @content_list = []
    contents.order(:position).each do |content|
      if content.contentable_type == "Video"
        video = Video.find(content.contentable_id)
        content_obj = {
          "id": content.id,
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
          "id": content.id,
          "kind": content.contentable_type,
          "name": ppt.name,
          "url": ppt.url
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

  def new
    @section = @course.sections.build
  end

  def create
    # many to many
    @section = section.create( section_params )
    @ship = coursesectionShip.new(
        :section_id => @section.id,
        :course_id => @course.id
    )
    if @ship.save
        redirect_to school_course_sections_url( @school, @course )
    else
        render :action => :new
    end
  end

  def edit
    @section = @course.sections.find( params[:id] )
  end

  def update
    @section = @course.sections.find( params[:id] )

    if @section.update( section_params )
        redirect_to school_course_sections_url( @school, @course )
    else
        render :action => :edit
    end
  end

  def destroy
    @section = @course.sections.find( params[:id] )
    @section.destroy

    redirect_to school_course_sections_url( @school, @course )
  end

  def quiz_content
    @modal_id = params[:modal_id]
    @ex = Exercise.find(params[:ex_id])
    cover_range = @ex.cover_range
    @quiz = Quiz.where(:cover_range => cover_range).sample
    respond_to do |format|
      format.js {
        render  :template => "sections/next_quiz.js.erb",
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
          render  :template => "sections/quiz_summit.success.js.erb",
          :layout => false
        }
      else
        format.js {
          render  :template => "sections/quiz_summit.error.js.erb",
          :layout => false
        }
      end
    end
  end

  protected

  def find_school
    if params[:school_id].present?
      @school = School.find( params[:school_id] )
    end
  end

  def find_course
    if params[:course_id].present?
      @course = Course.find( params[:course_id] )
    end
  end

  def section_params
    params.require(:section).permit(:name, :position)
  end
end
