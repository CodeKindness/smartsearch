module MailProvider
  class Account
    def initialize
      @contextio = ContextIO.new(ENV['CONTEXT_API_KEY'], ENV['CONTEXT_API_SECRET'])
      @account = @contextio.accounts[ENV['CONTEXT_ACCOUNT_ID']]
    end

    # Fetch all messages after syncing
    def messages!
      @account.sync!
      @account.messages
    end

    # Fetch all messages without syncing
    def messages
      @account.messages
    end
  end
end
