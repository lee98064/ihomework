class  Admin::MembersController < Admin::AdminController
    before_action :set_classroom

    def index
        @admins = User.with_role(:admin, @classroom)
        @teachers = User.with_role(:teacher, @classroom)
        @students = User.with_role(:student, @classroom)
    end


    def destroy
        user = User.find(params[:id])
        case params[:type]
        when "admin"
            user.remove_role(:admin, @classroom) if user.id != current_user.id
            @admins = User.with_role(:admin, @classroom)
        when "teacher"
            user.remove_role(:teacher, @classroom) if user.id != current_user.id
            @teachers = User.with_role(:teacher, @classroom)
        when "student" 
            user.remove_role(:student, @classroom)
            @students = User.with_role(:student, @classroom)
        end
    end

    private

    def set_classroom
        @classroom = Classroom.find(params[:classroom_id])
		if not current_user.has_any_role?({ :name => :admin, :resource => @classroom }, { :name => :teacher, :resource => @classroom })
			redirect_to classrooms_path
		end
    end
end