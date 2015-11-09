class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :slug
      t.integer :user_id
      t.integer :contact_id
      t.integer :order
      t.integer :rating
      t.string :name
      t.string :address
      t.string :website_url
      t.string :linkedin_url

      t.timestamps null: false
    end
  end
end
