class ChangeTemplateToReferenceInResume < ActiveRecord::Migration
  def change
    remove_column :resumes, :template
    add_column :resumes, :template_id, :integer
  end
end
