class CreateDefaultIdentities < ActiveRecord::Migration
  def change
    create_table :default_identities do |t|
      t.string :email
      t.string :password_digest
      t.references :user, index: true

      t.timestamps
    end
  end
end
