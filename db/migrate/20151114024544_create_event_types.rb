class CreateEventTypes < ActiveRecord::Migration
  def change
    create_table :event_types do |t|
      t.integer :user_id
      t.string :name
      t.string :highlight_color

      t.timestamps null: false
    end
  end
end
