class RenameSimplelistitemToSimpleitem < ActiveRecord::Migration
  def change
    rename_table :simplelistitems, :simpleitems
  end
end
