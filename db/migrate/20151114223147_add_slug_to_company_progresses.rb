class AddSlugToCompanyProgresses < ActiveRecord::Migration
  def change
    create_view :company_progresses, view_sql('company_progresses'), force: true
  end
end
