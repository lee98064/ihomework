class  Admin::MembersController < Admin::AdminController
    before_action :set_classroom

    def index
        @admins = User.with_role(:admin, @classroom)
        @students = User.with_role(:student, @classroom)
    end

    def new
        
    end

    def create
        success = 0
        error = 0
        params['members'].each do |member|
            user = User.where(email: member['email']).last
            unless user.nil?
                case member['type']
                when "admin"
                    user.add_role(:admin, @classroom)
                    user.remove_role(:student, @classroom)
                when "student"
                    user.add_role(:student, @classroom)
                    user.remove_role(:admin, @classroom) if current_user.id != user.id
                end
                success += 1
            else
                error +=1
            end
        end
        redirect_to admin_classroom_members_path(@classroom), notice: "成員新增完成!<br>#{success}位新增成功<br>#{error}位新增失敗"
    end


    def destroy
        user = User.find(params[:id])
        case params[:type]
        when "admin"
            user.remove_role(:admin, @classroom) if user.id != current_user.id
            @admins = User.with_role(:admin, @classroom)
        when "student" 
            user.remove_role(:student, @classroom)
            @students = User.with_role(:student, @classroom)
        end
    end

    private

    def set_classroom
        @classroom = Classroom.find(params[:classroom_id])
		if not current_user.has_any_role?({ :name => :admin, :resource => @classroom })
			redirect_to classrooms_path
		end
    end
end