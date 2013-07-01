require 'digest/sha2'

class User < ActiveRecord::Base
  attr_accessible :username, :password, :password_confirm, :email

  validates_presence_of :username, :password, :password_confirm, :email
  validates_format_of :email, :with => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  validates_length_of :password, :in => 6..20 # 介於 6~20
  validates_length_of :password_confirm, :in => 6..20 # 介於 6~20
  validates_length_of :username, :in => 6..20 # 介於 6~20
  validates_uniqueness_of :email


  def forget_me
    self.username = nil
    self.password = nil
    session[:user_id] = nil
  end

  def remember_me
    remember_me_for 2.weeks
  end

  def remember_me_for(time)
    remember_me_until time.from_now.utc
  end

  def remember_me_until(time)
    save(false)
  end

  def self.encrypt(password, salt)
    Digest::SHA2.hexdigest(password + 'kkb' + salt)
  end

  def generate_salt
    @salt = self.object_id.to_s + rand.to_s
  end
end
