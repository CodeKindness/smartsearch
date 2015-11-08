class AddSlugToModels < ActiveRecord::Migration
  def change
    add_column :contacts, :slug, :string, index: true
    add_column :messages, :slug, :string, index: true
  end
end
