class AddOrderToSimplelistitems < ActiveRecord::Migration
  def change
    add_column :simplelistitems, :order, :integer
  end
end
