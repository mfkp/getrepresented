# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
#  include PadlockAuthorization
#  rescue_from 'Acl9::AccessDenied', :with => :access_denied
  helper :all # include all helpers, all the time

  helper_method :current_user_session, :current_user, :current_member, :logged_in?, :current_user_is_admin?
  
#  def access_denied
#    respond_to do |format|
#      format.html do
#        store_location
#        redirect_to new_user_session_path
#      end
#      # format.any doesn't work in rails version < http://dev.rubyonrails.org/changeset/8987
#      # Add any other API formats here.  Some browsers send Accept: */* and 
#      # trigger the 'format.any' block incorrectly.
#      format.any(:json, :xml) do
#        request_http_basic_authentication 'Web Password'
#      end
#    end
#  end

  
  private
  
  def current_member_session
    return @current_member_session if defined?(@current_member_session) && !@current_member_session.nil?
    @current_member_session = MemberSession.find
  end

  def current_user_session
    return @current_user_session if defined?(@current_user_session) && !@current_user_session.nil?
    @current_user_session = UserSession.find
  end
  
  def current_user
    return @current_user if defined?(@current_user) && !@current_user.nil?
    @current_user = current_user_session && current_user_session.user
    #@current_user = current_user_session && current_user_session.record
  end
  
  def current_member
    return @current_member if defined?(@current_member) && !@current_member.nil?
    @current_member = current_member_session && current_member_session.member
  end
  
  def logged_in?
    current_user
  end

  def require_user
    unless current_user
      store_location
      flash[:notice] = "You must be logged in to access this page"
      redirect_to new_user_session_url
      return false
    end
  end
  
  def require_no_user
    if current_user
      store_location
      flash[:notice] = "You must be logged out to access this page"
      redirect_to :back
      return false
    end
  end
  
  def store_location
    session[:return_to] = request.request_uri
  end
  
  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
  
  def access_denied
    if !current_user
      flash[:notice] = 'You must be logged in.'
      redirect_to login_path
    end
  end  
  
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'f86fe8528a80847bd838645a74c2dfad'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  filter_parameter_logging :password, :password_confirmation
end
