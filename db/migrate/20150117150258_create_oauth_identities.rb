class CreateOauthIdentities < ActiveRecord::Migration
  def change
    create_table :oauth_identities do |t|
      t.string :uid
      t.string :provider
      t.references :user, index: true

      t.timestamps
    end
  end
end
