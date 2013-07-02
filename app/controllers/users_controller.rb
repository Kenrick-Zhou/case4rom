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

    if params[:agreement] == '1'    #判断是否同意协议

      @user = User.new(params[:user])
      respond_to do |format|

        if @user.password == ''   #判断密码是否为空
          flash[:notice] = 'The Password is blank'
          format.html { render :action => :signUp }
        else
          if @user.password == @user.password_confirm   #判断密码是否相同
            if @user.save
              session[:user_id] = @user.id  #保存session
              format.html { redirect_to :action => :test, :notice => 'User was successfully created.' }
              format.json { render :json => @user, :status => :created, :location => @user }
            else
              flash[:notice] = 'The Email or password is not correct'
              format.html { render :action => :signUp }
            end
          else
            flash[:notice] = 'The Password is not same'
            format.html { render :action => :signUp }
          end
        end
      end

    else    #END 判断是否同意协议
      flash[:notice] = 'please accept the agreement'
      redirect_to :action => :signUp
    end
  end


  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find_by_email(User.new(params[:user]).email)

    respond_to do |format|
      if @user
        if @user.update_attributes(params[:user])   #更新实体属性的值，即修改密码
          format.html { redirect_to :action => :test, notice: 'User was successfully updated.' }
          format.json { head :no_content }
        else
          flash[:notice] = 'User was not successfully updated'
          format.html { redirect_to :action => :forgot_password, :notice => 'User was not successfully updated' }
        end

      else
        flash[:notice] = 'email could not found'
        format.html { redirect_to :action => :forgot_password, :notice => 'username could not found.' }
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

    @user = User.new

    #@user = User.find_by_username(params[:username])

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
    #
    #redirect_to users_forgot_password_path
  end

  def make_password_reset_code
    # 待完成
    #self.password_reset_code = Digest::SHA1.hexdigest( 'kkb' )
  end

  def login

  end

  def redirect
    @user = User.find_by_email(params[:email])
    if @user and session[:user_id] == @user.id
      redirect_to :action => :test
    else
      respond_to do |format|
        if @user and '["'<< @user.password<< '"]'.to_s == params[:password].to_s

          $uid = @user.id #保存登陆的信息uid
          session[:user_id] = @user.object_id
          flash[:notice] = "User #{@user.username} was successfully login."
          format.html { redirect_to :action => :test, :notice => "User #{@user.username} was successfully login." }
          format.json { render :json => @user, :status => OK, :location => @user }
        else
          flash[:notice] = 'email or password is not correct'
          format.html { redirect_to :action => :login, :notice => 'User was not login.' }
          format.json { render json: @user.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  def signUp
    @user = User.new
    #if  params[:agreement] == '1'
    #else
    #  flash[:notice] = 'accept the agreement'
    #  render :action => :agreement
    #end
  end

  def agreement
  end

  def test

  end
end
