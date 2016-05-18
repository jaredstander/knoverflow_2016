class User < ActiveRecord::Base
  # attr_accessor :name, :email, :password, :password_confirmation
  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  # has_secure_password
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, case_sensitive: false
  validates :password, presence: true, length: { minimum: 8 }, confirmation: true
  # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  before_save { |user| user.email.downcase! }
end