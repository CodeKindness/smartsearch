class ContactMailer < ApplicationMailer
  def open_email(params)
    @body = params.delete(:body)
    mail(params)
  end
end
