class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :voteable, polymorphic: true

  # attr_accessor :up_voted, :voteable_type

  validates :voteable_id, :user, presence: true
  validates :user_id, uniqueness: { scope: :voteable_id }

  after_save :update_vote_count
end