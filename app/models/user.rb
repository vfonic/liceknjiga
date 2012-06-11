require 'digest/sha1'

class User < ActiveRecord::Base
  attr_protected :hashed_password, :salt
  attr_accessor :password
  
  has_many :photos, :foreign_key => "creator_id"
  
  has_many :photos_users
  has_many :likes, :through => :photos_users, :source => :photo
  
  has_many :users_friends
  has_many :friends, :through => :users_friends
  has_many :authorized_friends, :through => :users_friends, :source => :friend, :conditions => [ "authorized = ?", true ]
  has_many :unauthorized_friends, :through => :users_friends, :source => :friend, :conditions => [ "authorized = ?", false ]
#  has_and_belongs_to_many :friends, :class_name => 'User', :foreign_key => 'friend_id', :join_table => 'users_friends'
  
  EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i

  before_save :create_hashed_password
  after_save :clear_password

  scope :sorted, order("last_name ASC, first_name ASC")
  scope :search, lambda {|query| where(["first_name LIKE ? OR last_name LIKE ? OR username LIKE ? OR email LIKE ?", "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%"])
  }

  has_attached_file :avatar, :styles => { :small => "150x150>", :medium => "300x300>", :thumb => "100x100>" }

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.make_salt(username = "")
    Digest::SHA1.hexdigest("#{username} #{Time.now}")
  end

  def self.hash_with_salt(password = "", salt = "")
    Digest::SHA1.hexdigest("#{password} #{salt}")
  end

  def self.authenticate(username="", password="")
    user = User.where(:username => username)[0]
    unless user.blank?
      if User.hash_with_salt(password, user.salt) == user.hashed_password
        user
      else
        false
      end
    else
      false
    end
  end

  private

  def create_hashed_password
    # Whenever :password has a value hashing is needed
    unless password.blank?
      # always use "self" when assigning values
      self.salt = User.make_salt(username) if salt.blank?
      self.hashed_password = User.hash_with_salt(password, salt)
    end
  end
  
  def clear_password
    # for security and b/c hashing is not needed
    self.password = nil if self.password
  end
end
