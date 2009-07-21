class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    @categoryposts = Post.find(:all, :conditions => { :category_id => params[:id] } )
    #Student.find(:all, :conditions => { :first_name => "Harvey", :status => 1 })

  end

end
