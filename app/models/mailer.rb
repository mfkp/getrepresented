class Mailer < ActionMailer::Base
  def registration_confirmation(user)
    recipients  user.email
    from        "myagenda.org@gmail.com"
    subject     "Thank you for Registering at MyAgenda.org"
    body        :user => user
  end
end
