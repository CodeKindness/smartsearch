class Contact < ActiveRecord::Base
  extend FriendlyId
  friendly_id :token

  has_and_belongs_to_many :companies, join_table: 'companies_contacts'
  belongs_to :user
  has_many :messages
  has_many :user_aggregates

  validates :user_id, presence: true
  validates :email, presence: true
  validates :email, uniqueness: { scope: :user_id }

  def full_name
    return nil if first_name.nil? && last_name.nil?
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
