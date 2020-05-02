require 'securerandom'
class Classroom < ApplicationRecord
	resourcify
	before_create :createaddcode
	belongs_to :user
	has_many :posts, dependent: :destroy
	has_many :testlists, dependent: :destroy

	def createaddcode
		code = SecureRandom.hex(3)
		classroom = Classroom.where(addcode: code)
		while not classroom.empty?
			code = SecureRandom.hex(3)
			classroom = Classroom.where(addcode: code)
		end
		self.addcode = code
	end
end
