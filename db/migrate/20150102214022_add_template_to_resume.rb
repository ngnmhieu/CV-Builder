class AddTemplateToResume < ActiveRecord::Migration
  def change
    add_column :resumes, :template, :string
  end
end
