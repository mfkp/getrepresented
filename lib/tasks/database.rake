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
    puts "Adding 25 Categories to tag list..."
      ActiveRecord::Base.connection.execute("DELETE FROM 'tags'") #Clear out the old tags to make room for presets
      ActiveRecord::Base.connection.execute("INSERT INTO 'tags' ('id','name') VALUES ('1','Agriculture')")
      ActiveRecord::Base.connection.execute("INSERT INTO 'tags' ('id','name') VALUES ('2','Arts')")
      ActiveRecord::Base.connection.execute("INSERT INTO 'tags' ('id','name') VALUES ('3','Banking/Finance')")
      ActiveRecord::Base.connection.execute("INSERT INTO 'tags' ('id','name') VALUES ('4','Defense')")
      ActiveRecord::Base.connection.execute("INSERT INTO 'tags' ('id','name') VALUES ('5','Economy')")
      ActiveRecord::Base.connection.execute("INSERT INTO 'tags' ('id','name') VALUES ('6','Education')")
      ActiveRecord::Base.connection.execute("INSERT INTO 'tags' ('id','name') VALUES ('7','Energy')")
      ActiveRecord::Base.connection.execute("INSERT INTO 'tags' ('id','name') VALUES ('8','Environment')")
      ActiveRecord::Base.connection.execute("INSERT INTO 'tags' ('id','name') VALUES ('9','Foreign Relations')")
      ActiveRecord::Base.connection.execute("INSERT INTO 'tags' ('id','name') VALUES ('10','Government Affairs')")
      ActiveRecord::Base.connection.execute("INSERT INTO 'tags' ('id','name') VALUES ('11','Healthcare')")
      ActiveRecord::Base.connection.execute("INSERT INTO 'tags' ('id','name') VALUES ('12','Homeland Security')")
      ActiveRecord::Base.connection.execute("INSERT INTO 'tags' ('id','name') VALUES ('13','Immigration')")
      ActiveRecord::Base.connection.execute("INSERT INTO 'tags' ('id','name') VALUES ('14','Iraq')")
      ActiveRecord::Base.connection.execute("INSERT INTO 'tags' ('id','name') VALUES ('15','Judiciary')")
      ActiveRecord::Base.connection.execute("INSERT INTO 'tags' ('id','name') VALUES ('16','Labor & Workforce')")
      ActiveRecord::Base.connection.execute("INSERT INTO 'tags' ('id','name') VALUES ('17','Medicare/Medicaid')")
      ActiveRecord::Base.connection.execute("INSERT INTO 'tags' ('id','name') VALUES ('18','Native Americans')")
      ActiveRecord::Base.connection.execute("INSERT INTO 'tags' ('id','name') VALUES ('19','Small Business')")
      ActiveRecord::Base.connection.execute("INSERT INTO 'tags' ('id','name') VALUES ('20','Social Security')")
      ActiveRecord::Base.connection.execute("INSERT INTO 'tags' ('id','name') VALUES ('21','Transportation')")
      ActiveRecord::Base.connection.execute("INSERT INTO 'tags' ('id','name') VALUES ('22','Trade')")
      ActiveRecord::Base.connection.execute("INSERT INTO 'tags' ('id','name') VALUES ('23','Veteran Issues')")
      ActiveRecord::Base.connection.execute("INSERT INTO 'tags' ('id','name') VALUES ('24','Women Issues')")
      ActiveRecord::Base.connection.execute("INSERT INTO 'tags' ('id','name') VALUES ('25','Other')")
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