class UserSessionsController < ApplicationController
  def new
    @user_session = UserSession.new
  end
  
  def create
    @user_session.save do |result|
      if result
        flash[:notice] = "Login successful!"
        redirect_back_or_default root_url
      else
        render :action => :new
      end
    end
  end

  
  def destroy
    @user_session = UserSession.find
    @user_session.destroy
    flash[:notice] = "Successfully logged out."
    redirect_to root_url
  end
end
