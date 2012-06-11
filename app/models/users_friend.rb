class UsersFriend < ActiveRecord::Base
  attr_accessible :authorized

  belongs_to :user
  belongs_to :friend, :class_name => "User", :foreign_key => "friend_id"
end
