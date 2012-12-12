class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :force_login

  def force_login
    # ...
  end
end
