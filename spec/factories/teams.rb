# frozen_string_literal: true

FactoryBot.define do
  factory :team, parent: :user, class: Team.name do
    type { Team.name }
  end
end
