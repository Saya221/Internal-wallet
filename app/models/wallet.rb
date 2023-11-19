# frozen_string_literal: true

class Wallet < ApplicationRecord
  belongs_to :resourcable, polymorphic: true
end
