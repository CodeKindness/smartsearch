class AddCompanyIdToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :company_id, :integer
    add_index :messages, :company_id
  end
end
