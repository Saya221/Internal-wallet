# frozen_string_literal: true

class Wallet < ApplicationRecord
  belongs_to :resourcable, polymorphic: true

  scope :by_ids, ->(ids) { where id: ids }
end
