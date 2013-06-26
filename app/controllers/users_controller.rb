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
  #def create
  #  @user = User.new(params[:user])
  #  if @user.save
  #    printf '--------------------'
  #    redirect_to :action => :test
  #  else
  #    printf '+++++++++++++++++++++++'
  #    redirect_to :action => :signUp
  #  end
  #end
  def create
    @user = User.new(params[:user])
    respond_to do |format|

      if @user.password == ''
        flash[:notice] = 'The Password is blank'
        format.html { render :action => :signUp }
      else
        if @user.password == @user.password_confirm
          if @user.save
            format.html { redirect_to :action => :test, :notice => 'User was successfully created.' }
            format.json { render :json => @user, :status => :created, :location => @user }
          else
            flash[:notice] = 'The Email is not correct'
            format.html { render :action => :signUp }
          end
        else
          flash[:notice] = 'The Password is not same'
          format.html { render :action => :signUp }
        end
      end
    end
  end


  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find_by_username(params[:username])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to :action => :test, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
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

    #@user = User.new
    #
    #@user = User.find_by_username(params[:username])
    #
    #respond_to do |format|
    #  if @user
    #         update(@user.id)
    #
    #  else
    #    flash[:notice] = 'username is not found'
    #    format.html { render :action => :forgot_password, :notice => 'username is not found.' }
    #    format.json { render json: @user.errors, :status => :unprocessable_entity }
    #  end
    #end
    #self.make_password_reset_code

    #redirect_to users_forgot_password_path
  end

  def make_password_reset_code
    # 待完成
    #self.password_reset_code = Digest::SHA1.hexdigest( 'kkb' )
  end

  def login

  end

  def redirect
    @user = User.find_by_username(params[:username])
    session[:id]
    respond_to do |format|
      if @user and '["'<< @user.password<< '"]'.to_s == params[:password].to_s

        flash[:notice] = "User #{@user.username} was successfully login."
        format.html { redirect_to :action => :test, :notice => "User #{@user.username} was successfully login." }
        format.json { render :json => @user, :status => OK, :location => @user }
      else
        flash[:notice] = 'username or password is not correct'
        format.html { render :action => :login, :notice => 'User was not login.' }
        format.json { render json: @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def signUp
    @user = User.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  def test

  end
end
