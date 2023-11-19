# frozen_string_literal: true

FactoryBot.define do
  factory :wallet do
    balance { Faker::Number.between(from: 100.0, to: 1000.0) }
    resourcable { create %i[user team stock].sample }
  end
end
