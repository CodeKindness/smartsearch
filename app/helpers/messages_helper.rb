module MessagesHelper
  def badge(count)
    content_tag(:span, count, class: 'badge badge-danger') unless count.blank?
  end

  def message_class(user_aggregate)
    if user_aggregate.event_type == 'Message'
      return (%w(inbox spam trash).include?(user_aggregate.workflow_state) && user_aggregate.read_at.blank? ? 'unreaded' : nil)
    else
      return user_aggregate.start_at > Time.now.utc ? 'unreaded' : nil
    end
  end
end
