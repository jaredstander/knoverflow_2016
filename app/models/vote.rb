class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :voteable, polymorphic: true

  # attr_accessor :up_voted, :voteable_type

  validates :voteable_id, :user, presence: true
  validates :user_id, uniqueness: { scope: :voteable_id }

  after_save :update_vote_count

  def update_vote_count
    if up_voted 
      self.voteable.vote_count += 1
    else 
      self.voteable.vote_count -=1
    end
  self.voteable.save
  end
end