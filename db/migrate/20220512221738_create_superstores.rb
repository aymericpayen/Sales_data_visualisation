class CreateSuperstores < ActiveRecord::Migration[6.1]
  def change
    create_table :superstores do |t|
      t.string :order_id
      t.string :order_date
      t.string :customer_id
      t.string :state
      t.string :region
      t.string :product_id
      t.float :sales
      t.integer :quantity

      t.timestamps
    end
  end
end
