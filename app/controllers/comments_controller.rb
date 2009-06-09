class CommentsController < ApplicationController
  before_filter(:get_post)
  
  def create
    @comment = @post.comments.build(params[:comment])
    if @comment.save
      flash[:notice] = 'Comment was successfully added.'
      respond_to do |format|
        format.html { redirect_to post_url(@post) }
        format.xml  { render :xml => @comment,
          :status => :created, :location => @post }
      end
    else
      flash[:notice] = 'Comment was not added.'
      respond_to do |format|
        format.html { redirect_to post_url(@post) }
        format.xml  { render :xml => @comment.errors,
          :status => :unprocessable_entity }
      end
    end
  end
  
  private
  
  def get_post
    @post = Post.find(params[:post_id])
  end
  
end
