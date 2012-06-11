
class CommentsController < ApplicationController

  def create
    redirect_to ({:action => 'show', :id => @photo.id})
  end
end
