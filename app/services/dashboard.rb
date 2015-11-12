class Dashboard
  def initialize(user)
    @user = user
  end

  def activity_chart
    Message.group_by_day(:created_at, format: '%b %e').count
  end

  # @return [Hash]
  def progress_chart
    @user.messages.group(:workflow_state).count
  end
end
