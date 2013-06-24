class User < ActiveRecord::Base
  attr_accessor :username
  attr_accessible :username, :password, :password_confirm

  #validates :username, :presence => true
  def forget_me
    self.username = nil
    self.password            = nil
    save(false)
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
