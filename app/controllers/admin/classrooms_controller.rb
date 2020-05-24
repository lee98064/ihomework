class  Admin::ClassroomsController < Admin::AdminController
    before_action :set_classroom

    def show
    end



    private

    def set_classroom
        @classroom = Classroom.find(params[:id])
		if not current_user.has_any_role?({ :name => :admin, :resource => @classroom })
			redirect_to classrooms_path
		end
    end
end