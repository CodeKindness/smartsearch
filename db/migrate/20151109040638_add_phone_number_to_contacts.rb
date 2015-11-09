class AddPhoneNumberToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :phone_number, :integer
    add_column :contacts, :linkedin_url, :string
  end
end
