class AddWorkflowStateToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :workflow_state, :string, index: true
  end
end
