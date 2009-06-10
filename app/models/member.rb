class Member < ActiveRecord::Base
  acts_as_authentic
  has_many :users
end
