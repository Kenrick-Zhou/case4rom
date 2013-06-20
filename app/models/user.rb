class User < ActiveRecord::Base
  attr_accessible :password, :password_confirm, :username

  validates :username, :presence => true,
            :length => {:minimum => 3, :maximum => 30},
            :uniqueness => true,
            :format => {:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i}
  validates :password,  :presence => true,
            :length => {:minimum => 4, :maximum => 15}
  validates :password_confirm, :confirmation => true
  validates :username, :uniqueness => true

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

end
