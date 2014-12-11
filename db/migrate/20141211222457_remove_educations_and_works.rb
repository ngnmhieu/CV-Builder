class RemoveEducationsAndWorks < ActiveRecord::Migration
  def change
    drop_table :educations
    drop_table :works
  end
end
