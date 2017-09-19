module UserHelper
  def active_users
    User.where(active: true)
  end
end

module UserConcern
  def active_users
    User.where(active: true)
  end
end

class UserController
  before_action :get_active_users
  def get_active_users
    @active_users = User.where(active: true)
  end
end

class User < ActiveRecord::Base
  scope :active_users, ->() { where(active: true) }
end

class UserService
  def active_users
    User.where(active: true)
  end
end