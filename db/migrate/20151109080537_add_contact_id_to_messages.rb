class AddContactIdToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :contact_id, :integer, index: true, after: :user_id
  end
end
