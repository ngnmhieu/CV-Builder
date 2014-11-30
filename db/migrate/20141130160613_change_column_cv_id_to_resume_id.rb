class ChangeColumnCvIdToResumeId < ActiveRecord::Migration
  def change
    rename_column :personal_details, :cv_id, :resume_id
  end
end
