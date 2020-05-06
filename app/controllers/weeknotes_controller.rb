class  WeeknotesController < ApplicationController
	before_action :authenticate_user!
	before_action :set_classroom
	before_action :set_weeknote, except: [:index,:new]
	layout "inclassroom"
	def index
		@weeknotesubjects = Weeknotesubject.where(classroom_id: @classroom.id).includes(:user)
		@weeknotesubjects = Weeknotesubject.includes(:weeknotes).includes(:user)
	end

	def show
		@weeknote = Weeknote.find_or_initialize_by(weeknotesubject_id: @weeknotesubject.id,user_id: current_user.id)
	end

	def insert
		@weeknote = Weeknote.find_or_initialize_by(weeknotesubject_id: @weeknotesubject.id,user_id: current_user.id)
		@weeknote.content = params[:weeknote][:content]
		if @weeknote.save
			redirect_to classroom_weeknote_path(@classroom,@weeknote), notice: "儲存成功!"
		else
			render 'show', notice: "儲存失敗!"
		end
	end

	private

	def set_classroom
		@classroom = Classroom.find(params[:classroom_id])
		if not current_user.has_any_role?({ :name => :student, :resource => @classroom }, { :name => :admin, :resource => @classroom }, { :name => :teacher, :resource => @classroom })
			redirect_to classrooms_path
		end
	end

	def set_weeknote
		@weeknotesubject = Weeknotesubject.find(params[:id])
	end

	def weeknote_params
		params.require(:weeknote).permit(:content)
	end
end