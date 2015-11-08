class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.integer :user_id
      t.string :email
      t.integer :company_id
      t.string :position
      t.string :first_name
      t.string :last_name

      t.timestamps null: false
    end
  end
end
