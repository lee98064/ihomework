class  Admin::ClassroomsController < Admin::AdminController
    before_action :set_classroom
    before_action :verify_user

    def show

    end

    def edit

    end

    def update
        if @classroom.update(classroom_params)
            redirect_to admin_classroom_path(@classroom), notice: "更新成功!"
        else
            render 'edit'
        end
    end

    def destroy
        @classroom.destroy
        redirect_to classrooms_path, notice: "刪除成功!"
    end



    private

    def set_classroom
        @classroom = Classroom.find(params[:id])
    end

    def verify_user
        unless current_user.has_any_role?({ :name => :admin, :resource => @classroom })
            redirect_to classrooms_path
        end
    end

    def classroom_params
        params.require(:classroom).permit(:name,:describe,:addcode)
    end
end