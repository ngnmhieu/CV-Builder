class AddOrderToMultilineListItems < ActiveRecord::Migration
  def change
    add_column :multiline_list_items, :order, :integer
  end
end
