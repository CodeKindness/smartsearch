class CompanyProgress < ActiveRecord::Base
  belongs_to :company
  belongs_to :user

  def self.custom_order
    result = []
    result << 'CASE'
    %w(Pending Message).push(EventType.order(order: :desc).map(&:name)).flatten.each_with_index do |et,i|
      result << "WHEN event_type = '#{et}' THEN #{i}"
    end
    result << 'END;'
    result.join(' ')
  end
end
