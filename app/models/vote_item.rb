class VoteItem < ApplicationRecord
    belongs_to :vote
    has_many :vote_logs
end
