class  Admin::WeeknotesController < Admin::AdminController
    before_action :set_classroom
    before_action :set_weeknotesubject, only: [:show,:edit,:update,:destroy,:checkpage,:check]

    def index
        @weeknotesubjects = Weeknotesubject.includes(:user).where(classroom_id: @classroom.id).order("created_at DESC")
    end

    def show
    end

    def new
        @weeknotesubject = Weeknotesubject.new
    end

    def create
        @weeknotesubject = @classroom.weeknotesubjects.build(weeknotesubject_params)
		@weeknotesubject.user_id = current_user.id if current_user
		if @weeknotesubject.save
			redirect_to admin_classroom_weeknote_path(@classroom,@weeknotesubject), notice: "週記建立成功!"
		else
			render 'new', notice: "請檢查欄位是否都已填寫!"
		end
    end

    def edit
    end

    def update
        if @weeknotesubject.update(weeknotesubject_params)
            redirect_to admin_classroom_weeknote_path(@classroom,@weeknotesubject),notice: "更新成功!"
        else
            render 'edit'
        end
    end 

    def destroy
        @weeknotesubject.destroy
        redirect_to admin_classroom_weeknotes_path(@classroom),notice: "刪除成功!"
    end

    def checkpage
        @weeknote = Weeknote.where(id: params[:weeknote_id], weeknotesubject_id: @weeknotesubject.id).last
    end

    def check
        @weeknote = Weeknote.where(id: params[:weeknote_id], weeknotesubject_id: @weeknotesubject.id).last
        unless @weeknote.update(weeknote_params)
            render 'checkpage'
        end
    end

    private

    def set_classroom
        @classroom = Classroom.find(params[:classroom_id])
		if not current_user.has_any_role?({ :name => :admin, :resource => @classroom })
			redirect_to classrooms_path
		end
    end

    def set_weeknotesubject
        @weeknotesubject = Weeknotesubject.includes(:user,:weeknotes => :user).find(params[:id])
    end

    def weeknotesubject_params
		params.require(:weeknotesubject).permit(:title,:describe)
	end

    def weeknote_params
        params.require(:weeknote).permit(:suggest,:score)
    end
end