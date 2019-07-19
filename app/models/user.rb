class User < ApplicationRecord
  has_one_attached :avatar
  has_one_attached :github_qrcode
  has_one_attached :twitter_qrcode

  extend FriendlyId
  friendly_id :login, use: :slugged

  after_create UserCallbacks.new

  validates :login, presence: true
  validates :twitter_account, presence: true
  validates_with UserValidator
end
