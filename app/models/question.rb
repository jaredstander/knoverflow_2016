class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :votes, as: :voteable, dependent: :destroy
  validates :title, presence: true, allow_nil: false
  validates :content, presence: true, allow_nil: false
  validates :user, presence: true

  def sort_by_vote
    #
  end
end