class PostsController < ApplicationController
  #require 'sqlite3'
  #before_filter :has_permission?, :except => :index
  
#before_filter :require_user, :only => [:new, :edit, :create, :update, :destroy]
#  access_control do
#     allow logged_in
#     allow anonymous, :to => [:index, :show]
#  end

  
  # GET /posts
  # GET /posts.xml
  def index
    @posts = Post.search(params[:search], params[:page])
    if !params[:tab].nil?
      @tab = params[:tab]
    else
      @tab = "tab-1"
    end
    @page_member = Member.find_by_username(current_subdomain)
    if !@page_member.nil?
      if !@page_member.active?
        flash[:error] = "Warning: This member has not yet joined this site. Click here to petition " + @page_member.title + ". " + @page_member.last_name + " to join."
      end
      @questions = Post.questions(@page_member.id).search(params[:search], params[:page])
      @ideas = Post.ideas(@page_member.id).search(params[:search], params[:page])
      @problems = Post.problems(@page_member.id).search(params[:search], params[:page])
      @praise = Post.praise(@page_member.id).search(params[:search], params[:page])
      @allposts = [@qustions, @ideas, @problems, @praise]
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
    @post = Post.find(params[:id])
    if(@post.category_id != nil)
      @category = Category.find(@post.category_id)
    end
    if(@post.type_id != nil)
      @type = Type.find(@post.type_id)
    end
    @members = Member.all

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    
    @members = []
    for membership in current_user.memberships
       @members.push([membership.member.first_name + " " + membership.member.last_name, membership.member.id])
    end

    @allcategories = Category.all
    @categories = []
    for category in @allcategories
      @categories.push([category.name, category.id])
    end
    
    @alltypes = Type.all
    @types = []
    for type in @alltypes
      if type.name != 'Petition' #exclude petition type from new post types
        @types.push([type.name, type.id])
      end
    end

    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.xml
  def create
    @post = Post.new(params[:post])

    respond_to do |format|
      if @post.save
        flash[:notice] = 'Post was successfully created.'
        format.html { redirect_to(@post) }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        flash[:notice] = 'Post was successfully updated.'
        format.html { redirect_to(@post) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(posts_url) }
      format.xml  { head :ok }
    end
  end
  
  # GET /posts/1
  # GET /posts/1.xml
  def vote
    @post = Post.find(params[:id])
    @vote = params[:vote]
    if !current_user.voted_for?(@post)
      if @vote == "up" then
          current_user.vote_for(@post)
          flash[:notice] = "You voted this post up."
      end
      if @vote == "down" then
          current_user.vote_against(@post)
          flash[:notice] = "You voted this post down."
      end
   elsif current_user.voted_for?(@post)
     flash[:error] = "You have already voted."
   end

    respond_to do |format|
      format.html { redirect_to(@post) }
      format.xml  { head :ok }
    end
  end
  
  # GET /posts/rank/category/weeks
  # GET /posts/rank/1.xml
  def rank
    numWeeks = params[:weeks].to_i
    type = params[:type]
    
    if (type == "popular")
      @posts = Post.tally(
      {   :at_least => 1, 
          :at_most => 10000,  
          :start_at => numWeeks.weeks.ago,
          :end_at => 0.day.ago,
          :limit => 50,
          :conditions => ["vote = 't'"],
          :order => "posts.vote asc"
      })
    end

    if (type == "unpopular")
      @posts = Post.tally(
      {   :at_least => 1, 
          :at_most => 10000,  
          :start_at => numWeeks.weeks.ago,
          :end_at => 0.day.ago,
          :limit => 50,
          :conditions => ["vote = 'f'"],
          :order => "posts.vote asc"
      })
    end
    
    if (type == "active")
      @posts = Post.tally(
      {   :at_least => 1, 
          :at_most => 10000,  
          :start_at => numWeeks.weeks.ago,
          :end_at => 0.day.ago,
          :limit => 50,
          :order => "posts.vote asc"
      })
    end

    respond_to do |format|
      format.html #{ redirect_to(@post) }
      format.xml  { head :ok }
    end
  end
end
