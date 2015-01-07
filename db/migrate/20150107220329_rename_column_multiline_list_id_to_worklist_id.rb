class RenameColumnMultilineListIdToWorklistId < ActiveRecord::Migration
  def change
    rename_column :worklist_items, :multiline_list_id, :worklist_id
  end
end
