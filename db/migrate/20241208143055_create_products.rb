class CreateProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :products do |t|
      t.string :product_name

      t.timestamps
    end
  end
end
