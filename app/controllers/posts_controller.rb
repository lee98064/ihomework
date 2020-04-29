class  PostsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_classroom_id
	before_action :set_post_id, only: [:show,:edit]
	layout "inclassroom"

	def index
		@posts = Post.where(classroom_id: @classroom.id).includes(:user)
	end

	def new
		@post = @classroom.posts.build
	end

	def create
		@post = @classroom.posts.build(post_params)
		@post.user_id = current_user.id
		if @post.save
			redirect_to classroom_post_path(@post)
		else
			render 'new'
		end
	end

	def edit
	end

	def update
	end


	private

	def set_classroom_id
		@classroom = Classroom.find(params[:classroom_id])
		if not current_user.has_any_role?({ :name => :student, :resource => @classroom }, { :name => :admin, :resource => @classroom }, { :name => :teacher, :resource => @classroom })
			redirect_to classrooms_path
		end
	end

	def set_post_id
		@post = Post.find(params[:id])
	end

	def post_params
      params.require(:post).permit(:title,:content)
    end
end