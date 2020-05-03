class  TestlistsController < ApplicationController
	before_action :set_classroom
	before_action :set_testlist, except: [:index,:new,:create]
	layout "inclassroom"
	def index
		@testlists = Testlist.where(start: params[:start]..params[:end],classroom_id: @classroom.id ).includes(:user)
	end

	def new
		@testlist = Testlist.new
	end

	def create
		@testlist = @classroom.testlists.build(testlist_params)
		@testlist.user_id = current_user.id if current_user
		@testlist.save
	end

	def update
		if @testlist.user_id == current_user.id
			@testlist.update(testlist_params)
			@testlist.save
		end
	end

	def destroy
		if @testlist.user_id == current_user.id
			@testlist.destroy
		end
	end

	private

	def set_classroom
		@classroom = Classroom.find(params[:classroom_id])
		if not current_user.has_any_role?({ :name => :student, :resource => @classroom }, { :name => :admin, :resource => @classroom }, { :name => :teacher, :resource => @classroom })
			redirect_to classrooms_path
		end
	end

	def testlist_params
      params.require(:testlist).permit(:title,:describe,:start,:end,:color)
    end

    def set_testlist
    	@testlist = Testlist.find(params[:id])
    end
end