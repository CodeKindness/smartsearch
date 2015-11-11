class AddNestedSetToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :parent_id, :integer
    add_index :messages, :parent_id
    add_column :messages, :lft, :integer
    add_index :messages, :lft
    add_column :messages, :rgt, :integer
    add_index :messages, :rgt
    add_column :messages, :depth, :integer
    add_index :messages, :depth

    Message.rebuild!
  end
end
