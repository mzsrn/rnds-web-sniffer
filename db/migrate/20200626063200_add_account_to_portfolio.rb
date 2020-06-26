class AddAccountToPortfolio < ActiveRecord::Migration[6.0]
  def change
    add_column :portfolios, :account, :string
  end
end
