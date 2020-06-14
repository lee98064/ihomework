class Scoresheet < ApplicationRecord
	validates :name, presence: true
	belongs_to :user
	belongs_to :classroom
	has_many :scores, -> { order(:stunumber => :asc) }, dependent: :destroy
	accepts_nested_attributes_for :scores, allow_destroy: true
end
