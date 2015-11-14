class UserAggregate < ActiveRecord::Base
  belongs_to :aggregateable, polymorphic: true
  belongs_to :company
  belongs_to :contact
  belongs_to :user
end
