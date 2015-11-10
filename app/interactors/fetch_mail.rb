class FetchMail
  include Interactor

  before do
    context.messages = []
  end

  # Sync messages on Context.io
  # Import mail provider messages
  # Save imported messages
  # Delete mail provider message from saved
  # or deliver notification to sender for unknown user
  # @return [Context::messages] list of successfully imported messages
  def call
    messages = MailProvider::Account.new.messages!
    messages.each do |message|
      user = find_user(message.addresses['to'][0]['email'])
      if user.present?
        new_msg = user.messages.new message_params(message)
        if new_msg.save
          context.messages << new_msg
          MailProvider::Message.new(new_msg.mail_provider_id).delete
        end
      else
        SenderMailer.unknown_email(message.addresses['from']['email'], message.addresses['to'][0]['email']).deliver
      end
    end
  end

  def rollback
  end

  def find_user(email)
    User.find_by(nickname: /^[^@]*/.match(email).to_s)
  end

  def fetch_message_body(message)
    result = ''
    message.body_parts.each do |part|
      if part.type == 'text/html'
        return part.content
      end
      result = part.content
    end
    result
  end

  def message_params(message)
    {
        originated_at: Time.at(message.date),
        mail_provider_id: message.message_id,
        from: message.addresses['from']['email'],
        to: message.addresses['to'][0]['email'],
        subject: message.subject,
        body: fetch_message_body(message)
    }
  end
end
