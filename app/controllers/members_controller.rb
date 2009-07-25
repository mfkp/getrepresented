class MembersController < ApplicationController
  def index
    @members = Member.all.sort_by{|m| m.state.upcase}
  end
  
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
  
  # GET /members/1
  # GET /members/1.xml
  def show
  @member = Member.find(params[:id])
  @posts = Post.all
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @member }
    end
  end
  
  # GET /members/1/posts
  # GET /members/1/posts.xml
  def posts
  @member = Member.find(params[:id])
  @posts = Post.all
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @member }
    end
  end
end


