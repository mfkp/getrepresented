class MembersController < ApplicationController
  def new
    @member = Member.new
  end
  
  def create
    @member = Member.new(params[:member])
    if @member.save
      flash[:notice] = "Successfully created member."
      redirect_to root_url
    else
      render :action => 'new'
    end
  end
  
  def edit
    @member = Member.find(params[:id])
  end
  
  def update
    @member = Member.find(params[:id])
    if @member.update_attributes(params[:member])
      flash[:notice] = "Successfully updated member."
      redirect_to root_url
    else
      render :action => 'edit'
    end
  end
end
