class SchoolsController < ApplicationController
    before_action :set_school, :only => [ :show, :edit, :update, :destroy]

    def index
        @schools = School.all
    end

    def new
        @school = School.new
    end

    def create
        @school = School.new(school_params)
        if @school.save
            flash[:notice] = "school was successfully created"
            redirect_to :action => :index
        else
            render :action => :new
        end
    end

    def show
        @page_title = @school.name
    end

    def edit
    end

    def update
        if @school.update(school_params)
            flash[:notice] = "school was successfully updated"
            redirect_to :action => :show, :id => @school
        else
            render :action => :edit
        end
    end

    def destroy
        @school.destroy
        flash[:alert] = "school was successfully deleted"
        redirect_to :action => :index
    end

    private

    def school_params
        params.require(:school).permit(:name, :description)
    end

    def set_school
        @school = School.find(params[:id])
    end

end
