class UsersController < ApplicationController
  # GET /users
  # GET /users.json

  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

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
    if @user.save
      printf '--------------------'
      redirect_to :action => :test
    else
      printf '+++++++++++++++++++++++'
      redirect_to :action => :signUp
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

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  def forgot_password
    @forgotten_password = true
    self.make_password_reset_code
  end

  def make_password_reset_code
    # 待完成
    #self.password_reset_code = Digest::SHA1.hexdigest( 'kkb' )
  end

  def login
  end

  def redirect
    user = User.find_by_username(params[:username])
    if user and User.find_by_password(params[:password])
      printf '==================================='
      redirect_to :action => :test
    else
      redirect_to :action => :signUp
    end
  end

  def signUp

  end

  def test

  end
end
