class Contact < ActiveRecord::Base
  extend FriendlyId
  friendly_id :token

  belongs_to :user

  validates :user_id, presence: true
  validates :email, presence: true
  validates :email, uniqueness: { scope: :user_id }

  def full_name
    "#{first_name} #{last_name}"
  end

  protected

  def token
    loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      return random_token unless self.class.exists?(slug: random_token)
    end
  end
end
