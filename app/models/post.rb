class Post < ApplicationRecord
	belongs_to :classrooms
	belongs_to :user
end
