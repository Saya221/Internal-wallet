# frozen_string_literal: true

class Api::V1::TransferBalanceService < Api::V1::BaseService
  def initialize(args = {})
    @params = args[:params]
    @current_user_id = args[:current_user_id]
    @recipient_id = params[:recipient_id]
    @destination_id = params[:destination_id]
    @destination_type = params[:destination_type].in?(User::TYPE) ? params[:destination_type] : User.name
    @source_id = params[:source_id]
    @balance = params[:balance]
  end

  def call
    ActiveRecord::Base.transaction do
      set_statement_timeout
      lock_wallets
      update_balances
      create_transaction
    end

    wallets
  end

  private

  attr_reader :params, :current_user_id, :recipient_id, :destination_id, :destination_type, :source_id, :balance

  def source
    @source ||= current_user.wallets.find_by!(id: source_id)
  end

  def current_user
    @current_user ||= User.find_by!(id: current_user_id)
  end

  def destination
    @destination ||= recipient.wallets.find_by!(id: destination_id)
  end

  def recipient
    @recipient ||= destination_type.constantize.find_by!(id: recipient_id)
  end

  def transaction_params
    {
      balance: balance,
      source: source,
      destination: destination,
      recipient: recipient,
      last_updater: current_user
    }
  end

  def set_statement_timeout
    ActiveRecord::Base.connection.execute("SET LOCAL statement_timeout = #{Settings.pg.statement_timeout}")
  end

  def lock_wallets
    wallets.lock("FOR UPDATE")
    source.lock!
    destination.lock!
  end

  def wallets
    @wallets ||= Wallet.by_ids([destination_id, source_id])
  end

  def update_balances
    source.update!(balance: source.balance - balance)
    destination.update!(balance: destination.balance + balance)
  end

  def create_transaction
    current_user.transactions.create!(transaction_params)
  end
end
