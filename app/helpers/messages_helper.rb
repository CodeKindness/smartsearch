module MessagesHelper
  def badge(count)
    content_tag(:span, count, class: 'badge badge-danger') unless count.blank?
  end
end
