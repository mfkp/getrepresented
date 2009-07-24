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
    #@posts = Post.all
    @posts = Post.search(params[:search], params[:page])
    @page_member = Member.find_by_username(current_subdomain)
    if !@page_member.nil?
      @questionposts = Post.questions(@page_member.id)
      @ideaposts = Post.ideas(@page_member.id)
      @problemposts = Post.problems(@page_member.id)
      @praiseposts = Post.praise(@page_member.id)
      @allposts = [@qustionposts, @ideaposts, @problemposts, @praiseposts]
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
      @types.push([type.name, type.id])
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
end
