
class UsersController < ApplicationController

  before_filter :confirm_logged_in

  def friends
    @authorized_friends = User.find(session[:user_id]).authorized_friends
    @unauthorized_friends = User.find(session[:user_id]).unauthorized_friends
  end

  def search
    @users = User.search(params[:query])
    @user = User.find(session[:user_id])
  end
  
  def send_request
    @user = User.find(params[:id])
    @new_friend = User.find(session[:user_id])
    
    @user.friends << @new_friend

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'Friend request sent!' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "index" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def add
    @new_friend = User.find(params[:id])
    @user = User.find(session[:user_id])

    @users_friend = @user.users_friends.find_by_friend_id(@new_friend.id)
    @users_friend.authorized = true

    respond_to do |format|
      if @users_friend.save
        format.html { redirect_to @user, notice: 'Friend added! Hooray!' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "index" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def remove
    @new_friend = User.find(params[:id])
    @user = User.find(session[:user_id])
    @users_friend = @user.users_friends.find_by_friend_id(@new_friend.id).destroy

    respond_to do |format|
      format.html { redirect_to @user, notice: 'Friend removed' }
      format.json { render json: @user, status: :created, location: @user }
    end
  end

  # GET /users
  # GET /users.json
  def index
#    show
#    render('show')
    @users = User.sorted

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    if params[:id]
      @user = User.find(params[:id])
    else
      @user = User.find_by_username(params[:username])
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def delete
    @user = User.find(params[:id])
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User destroyed" }
      format.json { head :no_content }
    end
  end
end
