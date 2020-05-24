class Weeknotesubject < ApplicationRecord
	belongs_to :user
	belongs_to :classroom
	validates :title, presence: true
	has_many :weeknotes, dependent: :destroy
end
