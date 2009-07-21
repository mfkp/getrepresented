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
    @posts = Post.all

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
    @members = Member.all

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    @post = Post.new
    @members = []
    for membership in current_user.memberships
       @members.push([membership.member.first_name + " " + membership.member.last_name, membership.member.id])
    end
    #db = SQLite3::Database.new("db/development.sqlite3.db")
    #@categories = db.execute("select name, id from tags")
    @allcategories = Category.all
    @categories = []
    for category in @allcategories
      @categories.push([category.name, category.id])
    end
    #@categories = ActiveRecord::Base.connection.execute("select name, id from tags")
    #puts @categories

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
    #@post.tag_list = params[:tag_list]

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
