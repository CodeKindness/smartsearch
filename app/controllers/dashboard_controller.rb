class DashboardController < ApplicationController
  def index
    @dashboard = Dashboard.new(@current_user)
    @count = count
  end

  protected

  def count
    {
        companies: @current_user.companies.count,
        incoming: @current_user.messages.with_inbox_state.count,
        outgoing: @current_user.messages.with_sent_state.count,
        interviews: @current_user.user_aggregates.where(event_type: 'Interview').count,
        offers: @current_user.user_aggregates.where(event_type: 'Offer Letter').count
    }
  end
end
