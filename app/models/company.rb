class Company < ActiveRecord::Base
  extend FriendlyId
  friendly_id :token

  belongs_to :user
  belongs_to :contact

  validates :user_id, presence: true
  validates :name, presence: true

  protected

  def token
    loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      return random_token unless self.class.exists?(slug: random_token)
    end
  end
end
