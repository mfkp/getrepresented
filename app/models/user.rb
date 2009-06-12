class User < ActiveRecord::Base
  acts_as_authentic
  #acts_as_authorization_subject
  #acts_as_authorized_user
  
  has_and_belongs_to_many :members
  #has_and_belongs_to_many :roles
  
#  def has_role?(role_name, obj=nil)
#      self.role == role_name
#    end
#
#    def has_role!(role_name, obj=nil)
#      self.role = role_name
#      save!
#    end
end
