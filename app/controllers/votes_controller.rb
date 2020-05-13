class VotesController< ApplicationController
    before_action :authenticate_user!
	before_action :set_classroom
	before_action :set_vote, only: [:destroy,:show,:edit,:update,:vote,:addvote]
    layout "inclassroom"
    def index
        @votes = Vote.where(classroom_id: @classroom.id).includes(:user,:vote_items).order("created_at DESC")
	end
	
	def show
	end

	def new
		@vote = Vote.new
	end

	def create
		@vote = @classroom.votes.build(vote_params)
		@vote.user_id = current_user.id
		if @vote.save
			redirect_to classroom_votes_path(@classroom), notice: "投票新增成功!"
		else
			render 'new', notice: "投票新增失敗!請檢查欄位是否都有填寫!"
		end
	end

	def edit
	end

	def update
		if @vote.update(vote_params)
			redirect_to classroom_votes_path(@classroom), notice: "投票編輯成功!"
	    else
	    	render 'edit', notice: "投票編輯失敗!請檢查欄位是否都有填寫!"
	    end 
	end

	def vote
		@vote_log = VoteLog.find_or_initialize_by(vote_id: @vote,user_id: current_user.id)
	end

	def addvote
		@vote_log = VoteLog.find_or_initialize_by(vote_id: @vote.id,user_id: current_user.id)
		@vote_log.vote_item_id = params[:vote_log][:vote_item_id]
		if @vote_log.save
			redirect_to classroom_votes_path(@classroom), notice: "成功!"
		else
			render 'vote'
		end
	end
	
    private

	def set_classroom
		@classroom = Classroom.find(params[:classroom_id])
		if not current_user.has_any_role?({ :name => :student, :resource => @classroom }, { :name => :admin, :resource => @classroom }, { :name => :teacher, :resource => @classroom })
			redirect_to classrooms_path
		end
	end

	def set_vote
		@vote = Vote.includes(:vote_items).find(params[:id])
	end

	def vote_params
		params.require(:vote).permit(:title,:describe,vote_items_attributes: [:id, :title, :describe, :color,:_destroy])
	end
end