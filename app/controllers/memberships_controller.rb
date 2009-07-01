class MembershipsController < ApplicationController
  def create
    @membership = current_user.memberships.build(:member_id => params[:member_id])
    if @membership.save
      flash[:notice] = "Successfully created membership."
      redirect_to root_url
    else
      render :action => 'new'
    end
  end
  
  def destroy
    @membership = current_user.memberships.find(params[:id])
    @membership.destroy
    flash[:notice] = "Successfully destroyed membership."
    redirect_to root_url
  end
end
