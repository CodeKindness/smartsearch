class EventType < ActiveRecord::Base
  has_many :events

  validates :highlight_color, presence: true
  validates :name, presence: true
end
