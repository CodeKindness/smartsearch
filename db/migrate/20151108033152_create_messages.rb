class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :user_id
      t.string :mail_provider_id
      t.string :from
      t.string :to
      t.string :subject
      t.text :body
      t.datetime :originated_at

      t.timestamps null: false
    end
    add_index :messages, :user_id
  end
end
