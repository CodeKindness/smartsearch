class AddCreatedAtToUserAggregates < ActiveRecord::Migration
  def change
    create_view :user_aggregates, view_sql('user_aggregates'), force: true
  end
end
