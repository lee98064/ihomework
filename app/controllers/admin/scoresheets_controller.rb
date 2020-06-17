class  Admin::ScoresheetsController < Admin::AdminController
	before_action :authenticate_user!
	before_action :set_classroom
	before_action :set_scoresheet, only: [:edit,:update,:destroy]
	layout "admin"

	def index
		@scoresheets = Scoresheet.where(classroom_id: @classroom.id).includes(:user).order("created_at DESC")
	end

	def edit
	end


	def update
		if @scoresheet.update(scoresheet_params)
			redirect_to admin_classroom_scoresheets_path(@classroom), notice: "成績單編輯成功!"
		else
			render 'edit', notice: "成績單編輯失敗!請檢查欄位是否都有填寫!"
		end
	end

	def destroy
		@scoresheet.destroy
		redirect_to admin_classroom_scoresheets_path(@classroom), notice: "刪除成功!"
	end

	private

	def set_classroom
		@classroom = Classroom.find(params[:classroom_id])
		if not current_user.has_any_role?({ :name => :admin, :resource => @classroom })
			redirect_to classrooms_path
		end
	end

	def set_scoresheet
		@scoresheet = Scoresheet.includes(:scores).find(params[:id])
	end

	def scoresheet_params
		params.require(:scoresheet).permit(:name,:describe,scores_attributes: [:id, :stunumber, :score, :_destroy])
	end
end