class User < ApplicationRecord
  has_one_attached :avatar
  has_one_attached :qrcode
  has_one_attached :grass

  after_create UserCallbacks.new

  validates :name, presence: true
end
