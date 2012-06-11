class Photo < ActiveRecord::Base
  attr_accessible :private, :photo_data, :image

  belongs_to :creator, :class_name => 'User'
  
  has_many :photos_users
  has_many :likes, :through => :photos_users, :source => :user

  has_attached_file :photo_data, :styles => { :small => "150x150>", :medium => "300x300>", :thumb => "100x100>" }

end
