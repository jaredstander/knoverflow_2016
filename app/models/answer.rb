class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :votes, as: :voteable, dependent: :destroy
  validates :content, :question, :user, presence: true
  validates :user_id, uniqueness: { scope: :question_id }

  def sort_by_votes
    #
  end
end