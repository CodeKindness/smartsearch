class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :user_id, index: true
      t.integer :company_id
      t.integer :contact_id
      t.integer :event_type_id, index: true
      t.text :description
      t.datetime :start_at
      t.datetime :end_at

      t.timestamps null: false
    end
  end
end
