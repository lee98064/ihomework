class VotesController< ApplicationController
    before_action :authenticate_user!
	before_action :set_classroom
    layout "inclassroom"
    def index
        @votes = Vote.where(classroom_id: @classroom.id).includes(:user,:vote_items)
    end

	def new
		p @vote = Vote.new
	end

    private

	def set_classroom
		@classroom = Classroom.find(params[:classroom_id])
		if not current_user.has_any_role?({ :name => :student, :resource => @classroom }, { :name => :admin, :resource => @classroom }, { :name => :teacher, :resource => @classroom })
			redirect_to classrooms_path
		end
	end
end