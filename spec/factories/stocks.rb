# frozen_string_literal: true

FactoryBot.define do
  factory :stock, parent: :user, class: Stock.name do
    type { Stock.name }
  end
end
