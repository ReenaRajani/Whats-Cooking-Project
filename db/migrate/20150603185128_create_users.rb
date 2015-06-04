class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.text :email_id
      t.string :full_name
      t.timestamps
      t.string :password_digest
      t.boolean :admin, :default => 'false'
    end
  end
end
