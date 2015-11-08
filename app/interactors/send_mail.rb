class SendMail
  include Interactor

  # Send email
  # @params [user] User
  # @params [params] Hash
  # @option params [to] String
  # @option params [cc] String
  # @option params [from] String
  # @option params [subject] String
  # @option params [body] String
  def call
    ContactMailer.open_email(context.params).deliver
    context.message = context.user.messages.create context.params.merge(workflow_state: Message.states(:sent), originated_at: Time.now.utc)
  end
end
