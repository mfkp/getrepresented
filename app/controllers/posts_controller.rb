class PostsController < ApplicationController
  
  # GET /posts
  # GET /posts.xml
  def index
    @posts = Post.non_petitions().search(params[:search], params[:page])
    if !params[:tab].nil?
      @tab = params[:tab]
    else
      @tab = "tab-1"
    end
    
    @page_member = Member.find_by_username(current_subdomain)
    
    if !@page_member.nil?
      already_petitioned = false
      if current_user
        @user_petitions = Post.user_petitions(current_user.id)
        for petition in @user_petitions
          if petition.member_id == @page_member.id
            #set already_petitioned to true if the user has already signed this petition
            already_petitioned = true
          end
        end
      end
      
      current_membership = false
      if current_user
        for membership in current_user.memberships
          if @page_member.id == membership.member_id
            #set current_membership to true if the page member is assigned to the user
            current_membership = true
          end
        end
      end
      
      #print the petition info if the member hasn't signed up, a user is logged in, the user is assigned to that member, and has not already signed petition
      @print_petition = !@page_member.active? && current_membership && !already_petitioned
    else
      @print_petition = false
    end
    
    if !@page_member.nil?
      if @print_petition
        flash.now[:error] = "Notice: This member has not yet joined this site. " + "<a href=""#{url_for :controller => 'posts', :action => 'new', :type => Type.find_by_name('Petition to Join').id, :member_id => @page_member.id}"">Click here to ask " + @page_member.title + ". " + @page_member.last_name + " to join.</a>"
      end
      @questions = Post.questions(@page_member.id).search(params[:search], params[:page])
      @ideas = Post.ideas(@page_member.id).search(params[:search], params[:page])
      @problems = Post.problems(@page_member.id).search(params[:search], params[:page])
      @praise = Post.praise(@page_member.id).search(params[:search], params[:page])
      @petitions = Post.petitions(@page_member.id).search(params[:search], params[:page])
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

  # GET /posts/new/:type
  # GET /posts/new.xml
  def new
    
    @members = []
    if params[:member_id] == nil #if member id not defined in url
      for membership in current_user.memberships
         @members.push([membership.member.first_name + " " + membership.member.last_name, membership.member.id]) #add all memberships
      end
    else #if member id defined in url
      member = Member.find(params[:member_id]) #get that member
      @members.push([member.first_name + " " + member.last_name, member.id]) #select only that member
    end

    @allcategories = Category.all
    @categories = []
    for category in @allcategories
      @categories.push([category.name, category.id])
    end
    
    @types = []
    if params[:type] == nil #if post type not defined in url
      @alltypes = Type.all
      for type in @alltypes #get all types
        if type.name != 'Petition to Join' #exclude petition type from new post types
          @types.push([type.name, type.id])
        end
      end
    else #if post type deinfed in url
      type = Type.find(params[:type])
      @types.push([type.name, type.id])
      if type.name == 'Petition to Join'
        @petition_mode = true #set the petition mode on form
      else
        @petition_mode = false
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
  
  def manage_posts
    @posts = Post.all
  end
end