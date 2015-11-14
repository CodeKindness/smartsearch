class AddSlugToEvents < ActiveRecord::Migration
  def change
    add_column :events, :slug, :string, index: true
  end
end
