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
        interviews: 6,
        offers: 2
    }
  end
end
