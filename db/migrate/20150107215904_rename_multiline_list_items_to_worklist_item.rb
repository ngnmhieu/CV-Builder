class RenameMultilineListItemsToWorklistItem < ActiveRecord::Migration
  def change
    rename_table :multiline_list_items, :worklist_items
  end
end
