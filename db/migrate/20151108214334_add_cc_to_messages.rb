class AddCcToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :cc, :string
  end
end
