class User < ActiveRecord::Base
  has_many :companies
  has_many :company_activities
  has_many :contacts
  has_many :events
  has_many :messages
  has_many :user_aggregates

  validates :nickname, presence: true, uniqueness: true
  validates :time_zone, presence: true

  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
