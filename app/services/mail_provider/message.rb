module MailProvider
  class Message
    # @params [message_id] string mail provider id
    def initialize(message_id)
      @contextio = ContextIO.new(ENV['CONTEXT_API_KEY'], ENV['CONTEXT_API_SECRET'])
      @message = @contextio.accounts[ENV['CONTEXT_ACCOUNT_ID']].messages[message_id]
    end

    # Marks message as read
    def read
      @message.move_to ENV['CONTEXT_READ_FOLDER']
    end

    # Deletes message
    def delete
      @message.delete
    end
  end
end
