class Question < ActiveRecord::Base
  # attr_accessor :title, :content
  belongs_to :user
  has_many :answers
  has_many :comments, as: :commentable
  has_many :votes, as: :voteable
  validates :title, presence: true, allow_nil: false
  validates :content, presence: true, allow_nil: false
  validates :user, presence: true
end