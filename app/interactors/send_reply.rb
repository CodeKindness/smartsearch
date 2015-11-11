class SendReply
  include Interactor

  # Send email
  # @param [ActiveRecord::User] user
  # @param [ActiveRecord::Message] origin message being replied to
  # @param [Hash] params
  # @option params [String] :to
  # @option params [String] :cc
  # @option params [String] :from
  # @option params [String] :subject
  # @option params [String] :body
  def call
    ContactMailer.open_email(mail_params).deliver_now
    context.message = context.user.messages.create context.params.merge(parent_id: context.origin.id, workflow_state: Message.states(:sent), originated_at: Time.now.utc)
  end

  # @return [Hash]
  def mail_params
    {
        to: context.params[:to],
        cc: context.params[:cc],
        from: context.params[:from],
        subject: context.params[:subject],
        body: context.params[:body],
    }
  end
end
