class  WeeknotesController < ApplicationController
	before_action :authenticate_user!
	before_action :set_classroom
	before_action :set_weeknotesubject, except: [:index,:new]
	layout "inclassroom"
	def index
		# @weeknote = Weeknote.where(user_id: current_user.id)
		# p @weeknote
		# @weeknotesubjects = Weeknotesubject.includes(:user).where(classroom_id: @classroom.id)
		# @weeknotesubjects = @weeknotesubjects.includes(@weeknote).where("weeknotesubjects.id = weeknotes.weeknotesubject_id")
		# @weeknotesubjects = Weeknotesubject.joins(@weeknote)
		# p @weeknotesubjects[0].weeknotes
		# @weeknotes = Weeknote.includes(:weeknotesubject).where(user_id: current_user.id)
		# @weeknotesubjects = Weeknotesubject.left_outer_joins(:weeknotes).where(:weeknotes => {user_id: current_user.id}).select("users.*, profiles.field1, profiles.field2")
		# @weeknotesubjects = Weeknotesubject.includes(:user).joins("LEFT OUTER JOIN (SELECT * FROM weeknotes where user_id = #{current_user.id}) AS weeknotes on weeknotesubjects.id = weeknotes.weeknotesubject_id").preload(:weeknotes)
		# @weeknotesubjects = ActiveRecord::Base.connection.execute(
		# 	"SELECT 
		# 	weeknotesubjects.*, weeknotes.id AS weeknoteid FROM weeknotesubjects,weeknotes
		# 	LEFT OUTER JOIN 
		# 	(SELECT weeknotes.weeknotesubject_id,weeknotes.user_id FROM weeknotes WHERE weeknotes.user_id = #{current_user.id}) As weeknote 
		# 	ON weeknotesubjects.id = weeknote.weeknotesubject_id"
		# 	)
		
		# @weeknotes = Weeknote.where(user_id: current_user.id),weeknotes.weeknotesubject_id,weeknotes.user_id,weeknotes 
		# @weeknotesubjects = Weeknotesubject.user_weeknotelist(current_user.id)
		# @weeknotes = Weeknote.user_weeknote(current_user.id)
		@weeknotesubjects = Weeknotesubject.includes(:user,:weeknotes).where(classroom_id: @classroom.id).order("created_at DESC")
	end

	def show
		@weeknote = Weeknote.find_or_initialize_by(weeknotesubject_id: @weeknotesubject.id, user_id: current_user.id)
	end

	def insert
		@weeknote = Weeknote.find_or_initialize_by(weeknotesubject_id: @weeknotesubject.id, user_id: current_user.id)
		@weeknote.content = params[:weeknote][:content]
		if @weeknote.save
			redirect_to classroom_weeknote_path(@classroom,@weeknotesubject), notice: "儲存成功!"
		else
			render 'show', notice: "儲存失敗!"
		end
	end

	private

	def set_classroom
		@classroom = Classroom.find(params[:classroom_id])
		if not current_user.has_any_role?({ :name => :student, :resource => @classroom }, { :name => :admin, :resource => @classroom })
			redirect_to classrooms_path
		end
	end

	def set_weeknotesubject
		@weeknotesubject = Weeknotesubject.find(params[:id])
	end

	def weeknote_params
		params.require(:weeknote).permit(:content)
	end
end