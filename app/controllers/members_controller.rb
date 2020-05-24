class  MembersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_classroom
    layout "inclassroom"
    
    def index
        @admins = User.with_role(:admin, @classroom)
        @students = User.with_role(:student, @classroom)
    end



    private
    def set_classroom
		@classroom = Classroom.find(params[:classroom_id])
		if not current_user.has_any_role?({ :name => :student, :resource => @classroom }, { :name => :admin, :resource => @classroom })
			redirect_to classrooms_path
		end
	end
end