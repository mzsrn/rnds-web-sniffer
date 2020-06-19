class CreatePortfolios < ActiveRecord::Migration[6.0]
  def change
    create_table :portfolios do |t|
      t.json :data
      t.string :broker  
      t.timestamps
    end
    add_reference :portfolios, :user
  end
end
