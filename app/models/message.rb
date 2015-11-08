class Message < ActiveRecord::Base
  belongs_to :user

  scope :unread, -> { where(read_at: nil) }

  def read!
    self.touch :read_at
  end
end
