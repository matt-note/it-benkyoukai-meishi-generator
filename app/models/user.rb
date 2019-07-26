class User < ApplicationRecord
  extend FriendlyId
  friendly_id :login, use: :slugged

  after_create UserCallbacks.new

  validates :login, presence: true
  validates :twitter_account, presence: true
  validates_with UserValidator
end
