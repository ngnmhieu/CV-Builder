class RenameMultilineListToWorklist < ActiveRecord::Migration
  def change
    rename_table :multiline_lists, :worklists
  end
end
