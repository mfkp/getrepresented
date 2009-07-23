class Post < ActiveRecord::Base
  #acts_as_authorization_object
  #acts_as_authorizable
  acts_as_voteable
  #acts_as_taggable_on :tags
  
  logical_parent :member
  belongs_to :user, :foreign_key => 'created_by', :class_name => 'User'
  belongs_to :member
  has_many :comments
  has_many :responses
  has_and_belongs_to_many :category
  
  validates_presence_of :title, :body
  
  def self.search(search, page)
    paginate :page => page, :per_page => 10, :conditions => [ 'title like ?', "%#{search}%"], :order => 'created_at DESC'
  end
  
  def self.is_indexable_by(user, parent = nil)
#    user.members.include?(parent)
  end

  def self.is_creatable_by(user, parent = nil)
#    user.members.include?(parent)
  end

  def is_updatable_by(user, parent = nil)
    user.id == created_by #&& parent.is_active?
  end

  def is_deletable_by(user, parent = nil)
    user.id == created_by
  end

  def is_readable_by(user, parent = nil)
    true
  end

end
