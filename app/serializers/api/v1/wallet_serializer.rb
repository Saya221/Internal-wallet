# frozen_string_literal: true

class Api::V1::WalletSerializer < Api::V1::BaseSerializer
  attributes %i[id balance]

  def attributes *attrs
    super.slice(*fields_custom[:wallets])
  end

  ROOT = {
    wallets: %i[id balance]
  }.freeze
end
