class CreateSimplelists < ActiveRecord::Migration
  def change
    create_table :simplelists do |t|
      t.string :name
      t.references :resume, index: true

      t.timestamps
    end
  end
end
