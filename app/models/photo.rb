class Photo < ActiveRecord::Base
  attr_accessible :private, :photo_data, :image

  belongs_to :creator, :class_name => 'User'

  has_many :photos_likes
  has_many :likes, :through => :photos_likes, :source => :user

  has_many :comments

  has_many :photos_tags
  has_many :tags, :through => :photos_tags, :source => :user

  has_attached_file :photo_data, :styles => { :small => "150x150>", :medium => "300x300>", :thumb => "100x100>" }

end
