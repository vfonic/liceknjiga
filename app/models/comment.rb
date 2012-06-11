class Comment < ActiveRecord::Base
  attr_accessible :content, :photo_id, :user_id
end
