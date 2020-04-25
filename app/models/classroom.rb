require 'securerandom'
class Classroom < ApplicationRecord
	resourcify
	before_create :createaddcode
	belongs_to :user

	def createaddcode
		code = SecureRandom.hex(3)
		classroom = Classroom.where(addcode: code)
		while not classroom.empty?
			code = SecureRandom.urlsafe_base64(8)
			classroom = Classroom.where(addcode: code)
		end
		self.addcode = code
	end
end
