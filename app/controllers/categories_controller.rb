class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    @categoryposts = Post.find(:all, :conditions => { :category_id => params[:id] } )
  end

end
