class StaffsController < ApplicationController

    before_action :find_school

    def index
        @staffs = @school.staffs
    end

    def show
        @school_staff = @school.staffs.find( params[:id] )
    end

    def new
        @school_staff = @school.staffs.build
    end

    def create
        @school_staff = @school.staffs.build( school_staff_params )
        if @school_staff.save
            redirect_to school_staffs_url( @school )
        else
            render :action => :new
        end
    end

    def edit
        @school_staff = @school.staffs.find( params[:id] )
    end

    def update
        @school_staff = @school.staffs.find( params[:id] )

        if @school_staff.update( school_staff_params )
            redirect_to school_staffs_url( @school )
        else
            render :action => :edit
        end

    end

    def destroy
        @school_staff = @school.staffs.find( params[:id] )
        @school_staff.destroy

        redirect_to school_staffs_url( @school )
    end

    protected

    def find_school
        @school = School.find( params[:school_id] )
    end

    def school_staff_params
        params.require(:school_staff).permit(:name, :title)
    end

end
