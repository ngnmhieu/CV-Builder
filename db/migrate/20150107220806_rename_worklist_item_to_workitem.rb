class RenameWorklistItemToWorkitem < ActiveRecord::Migration
  def change
    rename_table :worklist_items, :workitems
  end
end
