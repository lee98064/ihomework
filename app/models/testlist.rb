class Testlist < ApplicationRecord
	validates :title, presence: true
	validates :start, presence: true
	validates :end, presence: true
	belongs_to :user
	belongs_to :classroom
end
