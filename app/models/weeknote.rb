class Weeknote < ApplicationRecord
	belongs_to :user
	belongs_to :weeknotesubject
end
