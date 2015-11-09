class User < ActiveRecord::Base
  has_many :companies
  has_many :contacts
  has_many :messages

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
