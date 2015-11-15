class AddOrderToEventTypes < ActiveRecord::Migration
  def change
    add_column :event_types, :order, :integer
    add_index :event_types, :order
  end
end
