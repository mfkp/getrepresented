class Mailer < ActionMailer::Base
  default :from => "myagenda.org@gmail.com"
  
  def registration_notification(user)
    mail(:to => user.email,
         :subject => "Thank you for Registering at MyAgenda.org",
         :body => user)
  end
end
