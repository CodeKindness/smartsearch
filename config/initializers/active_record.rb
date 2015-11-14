ActiveRecord::Migration.class_eval do
  def view_sql(view)
    File.read(Rails.root.join("db/views/#{view}.sql"))
  end
end
