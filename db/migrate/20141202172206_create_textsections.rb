class CreateTextsections < ActiveRecord::Migration
  def change
    create_table :textsections do |t|
      t.string :name
      t.text :content
      t.references :resume, index: true

      t.timestamps
    end
  end
end
