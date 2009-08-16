class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.openid_required_fields = [:nickname, :email, :postcode]
  end

  acts_as_voter
  
  has_many :memberships
  has_many :members, :through => :memberships
  
  validates_presence_of :password, :password_confirmation, :unless => :openid_identifier
  validates_presence_of :street_address, :city, :state, :zip

  
  private
  
  def map_openid_registration(registration)
    self.email = registration["email"] if email.blank?
    self.username = registration["nickname"] if username.blank?
    self.zip = registration["postcode"] if zip.blank?
  end
  
end
