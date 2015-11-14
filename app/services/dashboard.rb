class Dashboard
  def initialize(user)
    @user = user
  end

  def activity_chart
    @user.user_aggregates.group_by_day(:start_at, format: '%b %e').count
  end

  # @return [Hash]
  def progress_chart
    @user.messages.group(:workflow_state).count
  end
end
