class User < ActiveRecord::Base
  att_accessible :name, :email, :password, :password_confirmation
  has_many :questions, :answers, :comments, :votes
  has_secure_password
  validates :password, presence: true, length: {minimum: 8}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
end