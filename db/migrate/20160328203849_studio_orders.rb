class StudioOrders < ActiveRecord::Migration
  def change
    create_table :studio_orders do |t|
      t.references :studio, index: true, foreign_key: true
      t.references :order,  index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
