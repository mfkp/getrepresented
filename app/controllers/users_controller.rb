class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user.save do |result|
      if result
        flash[:notice] = "Registration successful!"
        redirect_back_or_default root_url
      else
        render :action => :new
      end
    end
  end
  
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated user."
      redirect_to root_url
    else
      render :action => 'edit'
    end
  end
end
