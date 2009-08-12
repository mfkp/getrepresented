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
  has_and_belongs_to_many :type
  
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
  
  named_scope :questions, lambda { |member| {:conditions => { :type_id => Type.find_by_name('Question'), :member_id => member } } }
  named_scope :ideas, lambda { |member| {:conditions => { :type_id => Type.find_by_name('Idea'), :member_id => member } } }
  named_scope :problems, lambda { |member| {:conditions => { :type_id => Type.find_by_name('Problem'), :member_id => member } } }
  named_scope :praise, lambda { |member| {:conditions => { :type_id => Type.find_by_name('Praise'), :member_id => member } } }
  named_scope :petitions, lambda { |member| {:conditions => { :type_id => Type.find_by_name('Petition to Join'), :member_id => member } } }
  named_scope :non_petitions, lambda { {:conditions => { :type_id => (Type.find_by_name('Question')) || (Type.find_by_name('Idea')) || (Type.find_by_name('Problem')) || (Type.find_by_name('Praise')) } } }
  named_scope :user_petitions, lambda { |user| {:conditions => { :type_id => Type.find_by_name('Petition to Join'), :created_by => user } } }

end
