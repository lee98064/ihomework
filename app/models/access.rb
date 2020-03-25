class Access < ApplicationRecord
	has_many :users

	def name
		self.accesstype
	end
end
