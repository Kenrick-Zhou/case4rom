# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController

  def create_session
    self.current_user = User.authenticate(params[:username], params[:password])
    if logged_in?
      if params[:remember_me] == '1'
        self.current_user.remember_me
        cookies[:authenticate] = { :value => self.current_user.username , :expires => Time.now }
      end
      redirect_back_or_default('/')
      flash[:notice] = 'Logged in successfully'
    else
      render :action => user.new.login
    end
  end

  def destroy_session
    if session[:user_id] != nil
       session[:user_id] = nil
    flash[:notice] = 'You have been logged out.'
    redirect_to :controller => 'users', :action => 'login'
    end
  end
end
