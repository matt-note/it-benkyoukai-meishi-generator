class User < ApplicationRecord
  has_one_attached :avatar
  has_one_attached :github_qrcode
  has_one_attached :twitter_qrcode

  extend FriendlyId
  friendly_id :name, use: :slugged

  before_create UserCallbacks.new
  after_create UserCallbacks.new

  validates :name, presence: true
  validates :login, presence: true
  validates :twitter_account, presence: true
end
