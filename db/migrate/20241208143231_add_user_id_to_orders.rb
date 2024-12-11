class AddUserIdToOrders < ActiveRecord::Migration[7.2]
  def change
    add_reference :orders, :user, null: false, foreign_key: true
  end
end
