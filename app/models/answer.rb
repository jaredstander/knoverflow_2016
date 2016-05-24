class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :votes, as: :voteable, dependent: :destroy
  validates :content, :question, :user, presence: true
  validates :user_id, uniqueness: { scope: :question_id }

  def sort_by_votes
    # select('posts.*, count(votes.id) as vote_count').joins('LEFT OUTER JOIN votes on votes.answer_id = posts.id').group_by('posts.id').order('votes_count desc')
  end
end