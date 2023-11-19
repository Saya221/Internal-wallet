# frozen_string_literal: true

class Transaction < ApplicationRecord
  belongs_to :recipient, class_name: User.name, foreign_key: :recipient_id
  belongs_to :creator, class_name: User.name, foreign_key: :creator_id
  belongs_to :last_updater, class_name: User.name, foreign_key: :last_updater_id
  belongs_to :source, class_name: Wallet.name, foreign_key: :source_id
  belongs_to :destination, class_name: Wallet.name, foreign_key: :destination_id

  enum transaction_type: %i[transfer deposit withdraw]

  validates :balance, presence: true, numericality: { greater_than: 0 }
  validates :transaction_type, inclusion: { in: transaction_types.keys }
end
