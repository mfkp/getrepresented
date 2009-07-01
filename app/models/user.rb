class User < ActiveRecord::Base
  acts_as_authentic
  acts_as_voter
  #acts_as_authorization_subject
  #acts_as_authorized_user
  
  #has_and_belongs_to_many :members
  has_many :memberships
  has_many :members, :through => :memberships

end
