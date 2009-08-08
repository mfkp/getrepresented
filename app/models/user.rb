class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.openid_required_fields = [:nickname, :email, :postcode]
  end

  acts_as_voter
  
  has_many :memberships
  has_many :members, :through => :memberships
  
  validates_uniqueness_of :username
  validates_presence_of :password, :unless => :openid_identifier
  validates_size_of :password, :within => 5..100, :unless => :openid_identifier
  validates_format_of :email,
    :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
  validates_format_of :username, :with => /^\w+$/i,
    :message => "can only contain letters and numbers."
  validates_confirmation_of :password
  validates_presence_of :street_address, :city, :state, :zip

  
  private
  
  def map_openid_registration(registration)
    self.email = registration["email"] if email.blank?
    self.username = registration["nickname"] if username.blank?
    self.zip = registration["postcode"] if zip.blank?
  end
  
end
