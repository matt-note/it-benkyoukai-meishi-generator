# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { "matsumoto" }
    login { "matt-note" }
    twitter_account { "matt59649858" }
  end
end
