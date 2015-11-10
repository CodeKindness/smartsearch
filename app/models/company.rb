class Company < ActiveRecord::Base
  extend FriendlyId
  friendly_id :token

  has_and_belongs_to_many :contacts, join_table: :companies_contacts
  belongs_to :contact
  belongs_to :user
  has_many :messages

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
