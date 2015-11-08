class SenderMailer < ApplicationMailer
  def unknown_email(sender, email)
    @email = email
    mail(to: sender, subject: "Couldn't find a user for #{email}")
  end
end
