class RemoveContactIdFromCompanies < ActiveRecord::Migration
  def change
    remove_column :companies, :contact_id
  end
end
