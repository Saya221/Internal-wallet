# frozen_string_literal: true

class Api::V1::WalletsController < Api::V1::BaseController
  def get_balance
    render_json current_user.wallet
  end
end
