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
    params = context.params.dup
    ContactMailer.open_email(params).deliver_now
    context.message = context.user.messages.create context.params.merge(workflow_state: Message.states(:sent), originated_at: Time.now.utc)
  end
end
