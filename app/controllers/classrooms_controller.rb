class  ClassroomsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_classroom , only: [:show,:update,:edit] 
	layout "classroom"
	def index
		if params[:admin]
			@classrooms = Classroom.with_role([:admin,:teacher], current_user).includes(:user)
		else
			@classrooms = Classroom.with_role([:student], current_user).includes(:user)
		end
		respond_to do |format|
			format.html
			format.js { render :layout => false }
		end
	end

	def show
		render :layout => "inclassroom"
	end

	def new
		@classroom = current_user.classrooms.build
	end

	def create
		@classroom = current_user.classrooms.build(classroom_params)
		if @classroom.save
			current_user.add_role(:admin, @classroom)
			redirect_to @classroom
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @classroom.update(classroom_params)
			redirect_to classroom_path(@classroom),notice: "修改成功！"
		else
			render 'edit'
		end

	end

	def destroy
	end

	def addcode
		classroom = Classroom.where(addcode: params[:addcode]).last
		if classroom
			current_user.add_role(:student, classroom)
			json = {
				success: true,
				classroom: "/classrooms/" + classroom.id.to_s
			}
		else
			json = {
				success: false
			}
		end
		render :json => json
	end

	private

	def set_classroom
		@classroom = Classroom.find(params[:id])
		if not current_user.has_any_role?({ :name => :student, :resource => @classroom }, { :name => :admin, :resource => @classroom }, { :name => :teacher, :resource => @classroom })
			redirect_to classrooms_path
		end
	end

	def classroom_params
      params.require(:classroom).permit(:name,:describe)
    end
end