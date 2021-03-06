class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :service_address
      t.string :purchaser_name, null: false
      t.integer :status, null: false, default: 0
      t.timestamps null: false

      t.references :user, index: true, foreign_key: true
    end
  end
end
