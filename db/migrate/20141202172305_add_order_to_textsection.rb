class AddOrderToTextsection < ActiveRecord::Migration
  def change
    add_column :textsections, :order, :integer
  end
end
