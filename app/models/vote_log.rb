class VoteLog < ApplicationRecord
    belongs_to :user
    belongs_to :vote
    belongs_to :vote_item, counter_cache: true
end
