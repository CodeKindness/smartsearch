class Message < ActiveRecord::Base
  extend FriendlyId
  friendly_id :token

  validates :user_id, presence: true
  validates :from, presence: true
  validates :to, presence: true

  include Workflow
  workflow do
    state :inbox do
      event :spam, :transitions_to => :spam
      event :trash, transitions_to: :trash
    end
    state :spam do
      event :inbox, transitions_to: :inbox
      event :trash, transitions_to: :trash
    end
    state :draft do
      event :send, :transitions_to => :sent
    end
    state :sent
    state :trash
  end

  belongs_to :user

  scope :unread, -> { where(read_at: nil) }

  after_create :create_contact

  def create_contact
    Contact.create(user_id: user_id, email: from)
  end

  def read!
    self.touch :read_at
  end

  def self.states(state)
    Message.workflow_spec.states.keys(state) || Message.workflow_spec.states.keys.first
  end

  def self.unread_counts(user)
    ActiveRecord::Base.connection.execute("SELECT messages.workflow_state AS state, COUNT(messages.id) AS COUNT FROM messages WHERE messages.user_id = #{user.id} AND messages.read_at IS NULL GROUP BY messages.workflow_state")
  end

  protected

  def token
    loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      return random_token unless self.class.exists?(slug: random_token)
    end
  end
end
