class RenameCvsToResumes < ActiveRecord::Migration
  def change
    rename_table :cvs, :resumes
  end
end
