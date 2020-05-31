class CreatePortfolios < ActiveRecord::Migration[6.0]
  def change
    create_table :portfolios do |t|
      t.json :data
      
      t.timestamps
    end
    add_reference :portfolios, :resource_setting
  end
end
