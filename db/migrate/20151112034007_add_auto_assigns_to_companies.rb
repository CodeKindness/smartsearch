class AddAutoAssignsToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :auto_assigns, :boolean, default: false
  end
end
