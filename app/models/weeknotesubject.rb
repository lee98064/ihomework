class Weeknotesubject < ApplicationRecord
	belongs_to :user
	belongs_to :classroom
	has_many :weeknotes, dependent: :destroy
end
