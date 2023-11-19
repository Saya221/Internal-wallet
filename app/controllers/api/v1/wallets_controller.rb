# frozen_string_literal: true

class Api::V1::WalletsController < Api::V1::BaseController
  def show
    wallet = current_user.wallets.find_by! id: params[:id]

    render_json wallet
  end

  def transfer
    wallets = Api::V1::TransferBalanceService.call(current_user: current_user, params: params)

    render_json wallets
  end
end
