class SendMail
  include Interactor

  # Send email
  # @params [user] ActiveRecord::User
  # @params [params] Hash
  # @option params [to] String
  # @option params [cc] String
  # @option params [from] String
  # @option params [subject] String
  # @option params [body] String
  def call
    ContactMailer.open_email(mail_params).deliver_now
    context.message = context.user.messages.create context.params.merge(workflow_state: Message.states(:sent), originated_at: Time.now.utc)
  end

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
