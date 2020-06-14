class Score < ApplicationRecord
	validates :stunumber, presence: true
	validates :score, presence: true
	belongs_to :scoresheet
end
