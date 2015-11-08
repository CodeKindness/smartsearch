class AddNicknameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :nickname, :string, index: true, after: :email
  end
end
