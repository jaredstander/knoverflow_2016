class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  # attr_accessor :content # The user_id needs to be accessible to use the seed file
  # but can be removed after development has ended.
  # user_id of the comment has been removed from mass assignment and is now done by specific sttribute assignment.
  validates :commentable_id, :content, :user, presence: true
end