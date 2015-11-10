class CreateJoinTable < ActiveRecord::Migration
  def change
    create_join_table :companies, :contacts do |t|
      # t.index [:company_id, :contact_id]
      # t.index [:contact_id, :company_id]
    end
  end
end
