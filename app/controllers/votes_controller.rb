class VotesController< ApplicationController
    before_action :authenticate_user!
	before_action :set_classroom
	before_action :set_vote, only: [:destroy,:show,:edit,:update]
    layout "inclassroom"
    def index
        @votes = Vote.where(classroom_id: @classroom.id).includes(:user,:vote_items)
	end
	
	def show
	end

	def new
		p @vote = Vote.new
	end

	def create
		@vote = @classroom.votes.build(vote_params)
		@vote.user_id = current_user.id
		if @vote.save
			redirect_to classroom_votes_path(@classroom)
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @vote.update(vote_params)
			redirect_to classroom_votes_path(@classroom), notice: "投票編輯成功!"
	    else
	    	render 'edit'
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
		params.require(:vote).permit(:title,:describe,vote_items_attributes: [:id, :title, :describe, :_destroy])
	end
end