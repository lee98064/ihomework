class  ClassroomsController < ApplicationController
	layout "classroom"
	def index
		@classrooms = Classroom.all		
		# 暫放
		# p Rails.application.eager_load!
		# p ActiveRecord::Base.descendants
	end
end