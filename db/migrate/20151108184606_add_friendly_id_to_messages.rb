class AddFriendlyIdToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :friendly_id, :string, index: true
  end
end
