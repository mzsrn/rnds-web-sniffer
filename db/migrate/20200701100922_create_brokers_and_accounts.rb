class CreateBrokersAndAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :brokers do |t|
      t.string :name
      t.references :user

      t.timestamps
    end

    create_table :accounts do |t|
      t.string :number
      t.references :user
      t.references :broker

      t.timestamps
    end

    create_table :balances do |t|
      t.string :currency
      t.float :value
      t.references :account

      t.timestamps
    end
    add_reference :portfolios, :broker
    add_reference :portfolios, :account
  end
end
