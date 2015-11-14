class Event < ActiveRecord::Base
  extend FriendlyId
  friendly_id :token

  belongs_to :company
  belongs_to :contact
  belongs_to :event_type
  belongs_to :user
  has_many :user_aggregates, as: :aggregateable

  validates :event_type_id, presence: true
  validates :start_at, presence: true
  validates :user_id, presence: true

  protected

  def token
    loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      return random_token unless self.class.exists?(slug: random_token)
    end
  end
end
