class Weeknote < ApplicationRecord
	validates :content, presence: true
	belongs_to :user
	belongs_to :weeknotesubject, counter_cache: true
end
