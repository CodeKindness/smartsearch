class Message < ActiveRecord::Base
  extend FriendlyId
  friendly_id :token

  validates :user_id, presence: true
  validates :from, presence: true
  validates :to, presence: true

  belongs_to :user

  scope :unread, -> { where(read_at: nil) }

  after_create :create_contact

  def create_contact
    Contact.create(user_id: user_id, email: from)
  end

  def read!
    self.touch :read_at
  end

  protected

  def token
    loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      return random_token unless self.class.exists?(slug: random_token)
    end
  end
end
