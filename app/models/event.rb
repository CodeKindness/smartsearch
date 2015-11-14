class Event < ActiveRecord::Base
  belongs_to :company
  belongs_to :contact
  belongs_to :event_type
  belongs_to :user

  validates :event_type_id, presence: true
  validates :start_at, presence: true
  validates :user_id, presence: true
end
