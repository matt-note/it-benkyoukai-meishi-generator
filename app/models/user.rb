class User < ApplicationRecord
  after_create UserCallbacks.new

  validates :login, presence: true
  validates :twitter_account, presence: true
  validates_with UserValidator

  generate_public_uid generator: PublicUid::Generators::HexStringSecureRandom.new(20)

  def to_param
    public_uid
  end

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
