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
    puts "Done!"
  end

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