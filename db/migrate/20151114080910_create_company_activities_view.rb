class CreateCompanyActivitiesView < ActiveRecord::Migration
  def change
    create_view :company_activities, view_sql('company_activities'), force: true
  end
end
