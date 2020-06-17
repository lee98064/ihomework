class  Admin::PostsController < Admin::AdminController
	before_action :authenticate_user!
	before_action :set_classroom
	before_action :set_post, only: [:show,:edit,:update,:destroy]
	layout "admin"

	def index
		@posts = Post.where(classroom_id: @classroom.id).includes(:user).order("created_at DESC")
	end

	def show
	end

	def new
		@post = Post.new
	end

	def create
		@post = @classroom.posts.build(post_params)
		@post.user_id = current_user.id if current_user
		if @post.save
			# ContactMailer.new_post(users).deliver_now
			NewPostEmailJob.perform_later(@classroom,@post)
			redirect_to admin_classroom_post_path(@classroom,@post), notice: "公告建立成功!"
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @post.update(post_params)
			redirect_to admin_classroom_post_path(@classroom,@post), notice: "文章編輯成功!"
	    else
	    	render 'edit'
	    end 
	end

	def destroy
		@post.destroy
		redirect_to admin_classroom_posts_path, notice: "公告刪除成功!"
	end

	private

	def set_classroom
		@classroom = Classroom.find(params[:classroom_id])
		if not current_user.has_any_role?({ :name => :admin, :resource => @classroom })
			redirect_to classrooms_path
		end
	end

	def set_post
		@post = Post.find(params[:id])
	end

	def post_params
      params.require(:post).permit(:title,:content)
    end
end