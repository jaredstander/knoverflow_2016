class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :voteable, polymorphic: true

  # attr_accessor :up_voted, :voteable_type

  validates :voteable_id, :user, presence: true
  validates :user_id, uniqueness: { scope: :voteable_id }

  after_save :update_vote_count
  after_destroy :update_vote_count

  def update_vote_count
    @voted_item = self.voteable
    @voted_item.vote_count = @voted_item.votes.count
    @voted_item.save
  end
end