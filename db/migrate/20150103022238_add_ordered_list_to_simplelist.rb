class AddOrderedListToSimplelist < ActiveRecord::Migration
  def change
    add_column :simplelists, :ordered_list, :boolean
  end
end
