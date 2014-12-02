class AddOrderToSimplelists < ActiveRecord::Migration
  def change
    add_column :simplelists, :order, :integer
  end
end
