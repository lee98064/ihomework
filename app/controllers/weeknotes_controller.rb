class  WeeknotesController < ApplicationController
	before_action :authenticate_user!
	before_action :set_classroom
	before_action :set_weeknote, except: [:index,:new,:create]
	layout "inclassroom"
	def index
		@weeknotesubjects = Weeknotesubject.where(classroom_id: @classroom.id).includes(:user)
	end

	def show

	end

	def new
		@weeknote = Weeknote.new
	end

	def create

	end

	def edit

	end

	def update
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
end