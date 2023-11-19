# frozen_string_literal: true

class Api::V1::BaseService < BaseService
  class << self
    def call(*args)
      new(*args).call
    end
  end
end
