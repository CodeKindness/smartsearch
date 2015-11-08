class RemoveFriendlyIdFromMessages < ActiveRecord::Migration
  def change
    remove_column :messages, :friendly_id
  end
end
