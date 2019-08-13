class User < ApplicationRecord
  extend FriendlyId
  friendly_id :login, use: :slugged

  after_create UserCallbacks.new

  validates :login, presence: true
  validates :twitter_account, presence: true
  validates_with UserValidator

  def avatar_path
    Rails.root.join("tmp/#{login}.jpg").to_s
  end

  def github_qrcode_path
    Rails.root.join("tmp/#{login}-github-qrcode.png").to_s
  end

  def twitter_qrcode_path
    Rails.root.join("tmp/#{login}-twitter-qrcode.png").to_s
  end
end
