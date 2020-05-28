class CreateResourceSettings < ActiveRecord::Migration[6.0]
  def change
    create_table :resource_settings do |t|
      t.string :login
      t.string :password
      t.string :type

      t.timestamps
    end
  end
end
