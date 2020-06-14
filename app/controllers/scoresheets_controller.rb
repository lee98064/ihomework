class ScoresheetsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_classroom
	before_action :set_scoresheet, only: [:show,:edit,:update,:destroy]
	before_action :verify_user, only: [:edit,:update,:destroy]
	layout "inclassroom"

	def index
		@scoresheets = Scoresheet.where(classroom_id: @classroom.id).includes(:user).order("created_at DESC")
	end

	def show
		respond_to do |format|
		  format.html
	      format.xls
	    end
	end

	def new
		@scoresheet = Scoresheet.new
	end

	def create
		@scoresheet = @classroom.scoresheets.build(scoresheet_params)
		@scoresheet.user_id = current_user.id
		if @scoresheet.save!
			redirect_to classroom_scoresheet_path(@classroom, @scoresheet), notice: "成績單新增成功!"
		else
			render 'new', notice: "成績單新增失敗!請檢查欄位是否都有填寫!"
		end
	end

	def edit
	end

	def update
		if @scoresheet.update(scoresheet_params)
			redirect_to classroom_scoresheet_path(@classroom,@scoresheet), notice: "成績單編輯成功!"
		else
			render 'edit', notice: "成績單編輯失敗!請檢查欄位是否都有填寫!"
		end
	end

	def destroy
		@scoresheet.destroy
		redirect_to classroom_scoresheets_path(@classroom), notice: "刪除成功!"
	end

	private

	def scoresheet_params
		params.require(:scoresheet).permit(:name,:describe,scores_attributes: [:id, :stunumber, :score, :_destroy])
	end

	def set_scoresheet
		@scoresheet = Scoresheet.includes(:scores).find(params[:id])
	end

	def set_classroom
		@classroom = Classroom.find(params[:classroom_id])
		if not current_user.has_any_role?({ :name => :student, :resource => @classroom }, { :name => :admin, :resource => @classroom })
			redirect_to classrooms_path
		end
	end

	def verify_user
    	unless @scoresheet.user_id == current_user.id
		 	redirect_to classroom_post_path(@classroom,@scoresheet), notice: "您沒有權限進行操作!"
		end 
    end
end