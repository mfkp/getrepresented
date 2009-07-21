namespace :db do
  desc "Get all current congress members and add them to the database"
  task :update_members => :environment do
    count = 0
    puts "Getting current congress members..."
    allMembers = Sunlight::Legislator.all_where(:in_office => 1) #get all current congress members
    puts "Adding new members to database..."
    allMembers.each do |member|
      if Member.find(:first, :conditions => {:first_name => member.firstname, :last_name => member.lastname}) == nil
        username = formatString(member.firstname) + formatString(member.lastname)
        if (member.email == "")
              email = username + "@demo.com"
        else
            email = member.email
        end
        @newMember = Member.new(:first_name => member.firstname, :last_name => member.lastname, :username =>username, :profile => "", :email => email, :password => "password", :password_confirmation => "password")
        if @newMember.save
            puts "Sucessfully added member " + member.firstname + " " + member.lastname + ", username: " + username
        else
            puts "ERROR ADDING MEMBER " + member.firstname + " " + member.lastname + ", username: " + username
        end
          count += 1
      end
    end
    puts "Added " + count.to_s + " members to the database."
  end
  
  desc "Populates the tag list with categories"
  task :add_categories => :environment do
    puts "Adding categories to tag list..."
      categorylist = ["Agriculture", "Arts", "Banking/Finance", "Defense", "Economy", "Education", "Energy", "Environment",
                      "Foreign Relations", "Government Affairs", "Healthcare", "Homeland Security", "Immigration", "Iraq",
                      "Judiciary", "Labor and Workforce", "Medicare/Medicaid", "Native Americans", "Small Business",
                      "Social Security", "Transportation", "Trade", "Veteran Issues", "Women Issues", "Other"]
      categorylist.each do |category|
        if Category.find(:first, :conditions => {:name => category}) == nil
          puts "Adding category " + category
          @newCategory = Category.new(:name => category)
          @newCategory.save
        end
      end
      
    puts "Done!"
  end
  
  desc "Updates congress members and categories"
  task :update_all => [:update_members, :add_categories]

  def formatString(str)
    # Based on permalink_fu by Rick Olsen
    # Escape str by transliterating to UTF-8 with Iconv
    s = Iconv.iconv('ascii//ignore//translit', 'utf-8', str).to_s
    # Downcase string
    s.downcase!
    # Replace any non-letter or non-number character with a space
    s.gsub!(/[^A-Za-z0-9]+/, '')
    # Remove spaces from beginning and end of string
    s.strip!
    # Remove groups of spaces
    s.gsub!(/\ +/, '')
    return s
  end
end