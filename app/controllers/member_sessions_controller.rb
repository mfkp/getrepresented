class MemberSessionsController < ApplicationController
  
  def new
    @user_session = MemberSession.new
  end
  
  def create
    @member_session = MemberSession.new(params[:member_session])
    if @member_session.save
      flash[:notice] = "Successfully logged in."
      redirect_to root_url
    else
      render :action => 'new'
    end
  end
  
  def destroy
   @member_session = MemberSession.find
   @member_session.destroy
    flash[:notice] = "Successfully logged out."
    redirect_to root_url
  end
 
end
