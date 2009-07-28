class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
      geo = Geokit::Geocoders::GoogleGeocoder.geocode @user.street_address + ", " + @user.city + ", " + @user.state + " " + @user.zip
    @user.lat = geo.lat
    @user.lng = geo.lng
    if @user.save
       @mymembers = Sunlight::Legislator.all_for(:latitude => @user.lat, :longitude => @user.lng)
         @senior_senator = @mymembers[:senior_senator]
         @junior_senator = @mymembers[:junior_senator]
         @representative = @mymembers[:representative]
         
         if !@senior_senator.nil?
            @ss_id =Member.find_by_sql(["select id from members where first_name=? and last_name=?", @senior_senator.firstname, @senior_senator.lastname])
            @membership = current_user.memberships.build(:member_id => @ss_id[0].id)
            @membership.save
         end
         if !@junior_senator.nil?
            @js_id =Member.find_by_sql(["select id from members where first_name=? and last_name=?", @junior_senator.firstname, @junior_senator.lastname])
            @membership = current_user.memberships.build(:member_id => @js_id[0].id)
            @membership.save
         end
         if !@representative.nil?
            @rep_id =Member.find_by_sql(["select id from members where first_name=? and last_name=?", @representative.firstname, @representative.lastname])
            @membership = current_user.memberships.build(:member_id => @rep_id[0].id)
            @membership.save
         end
      flash[:notice] = "Registration Successful."
      redirect_to root_url
    else
      render :action => 'new'
    end
  end
  
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated profile."
      redirect_to root_url
    else
      render :action => 'edit'
    end
  end
end
