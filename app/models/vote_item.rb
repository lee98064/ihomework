class VoteItem < ApplicationRecord
    validates :title, presence: true
    belongs_to :vote
    has_many :vote_logs, dependent: :destroy
end
