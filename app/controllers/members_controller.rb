class  MembersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_classroom
    layout "inclassroom"
    
    def index
        @admins = User.with_role(:admin, @classroom)
        @students = User.with_role(:student, @classroom)
    end

    def destroy
        case params[:type]
        when "admin"
            current_user.remove_role(:admin, @classroom) if current_user.id != current_user.id
        when "student" 
            current_user.remove_role(:student, @classroom)
        end
        redirect_to classrooms_path, notice: "操作成功!"
    end

    private
    def set_classroom
		@classroom = Classroom.find(params[:classroom_id])
		if not current_user.has_any_role?({ :name => :student, :resource => @classroom }, { :name => :admin, :resource => @classroom })
			redirect_to classrooms_path
		end
	end
end