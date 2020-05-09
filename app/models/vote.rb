class Vote < ApplicationRecord
    belongs_to :user
    belongs_to :classroom
    has_many :vote_items
    has_many :vote_logs
    accepts_nested_attributes_for :vote_items, allow_destroy: true
end
