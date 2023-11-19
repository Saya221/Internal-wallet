class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.decimal :balance, precision: 10, scale: 2, default: 0.0
      t.integer :transaction_type, default: 0
      t.references :source, type: :uuid
      t.references :destination, type: :uuid
      t.references :recipient, type: :uuid
      t.references :creator, type: :uuid
      t.references :last_updater, type: :uuid

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
