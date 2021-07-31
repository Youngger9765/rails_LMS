class SchoolsController < ApplicationController
    def index
        @schools = School.all
    end

    def new
        @school = School.new
    end

    def create
        @school = School.new(school_params)
        @school.save

        redirect_to :action => :index
    end

    def show
        @school = School.find(params[:id])
    end

    def edit
        @school = School.find(params[:id])
    end

    def update
        @school = Event.find(params[:id])
        @school.update(school_params)

        redirect_to :action => :show, :id => @school
    end

    private

    def school_params
        params.require(:school).permit(:name, :description)
    end

end
