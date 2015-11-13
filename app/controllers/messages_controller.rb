class MessagesController < ApplicationController
  before_action :set_message, only: [:respond, :show, :edit, :update, :destroy]

  # GET /messages
  def index
    @messages = current_user.messages.with_inbox_state.order(originated_at: :desc)
  end

  # GET /messages/sent
  def sent
    @messages = current_user.messages.with_sent_state.order(originated_at: :desc)
    render :index
  end

  # GET /messages/spam
  def spam
    @messages = current_user.messages.with_spam_state.order(originated_at: :desc)
    render :index
  end

  # GET /messages/drafts
  def drafts
    @messages = current_user.messages.with_draft_state.order(originated_at: :desc)
    render :index
  end

  # GET /messages/trash
  def trash
    @messages = current_user.messages.with_trash_state.order(originated_at: :desc)
    render :index
  end

  # GET /messages/:id
  def show
    @message.read!
    @messages = @message.root? ? @message.self_and_descendants : @message.self_and_ancestors.reverse
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # POST /messages
  def create
    @context = SendMail.call(message_params)

    if @context.success?
      redirect_to messages_path, notice: "Message was successfully sent to #{@context.message.to}."
    else
      render :new
    end
  end

  # PUT /messages/:id/spam

  # POST /messages/:id
  def respond
    @context = SendMail.call(response_params)

    if @context.success?
      redirect_to messages_path, notice: "Message was successfully sent to #{@context.message.to}."
    else
      flash.now[:message] = "Problem sending message: #{@context.message}"
      render :show
    end
  end

  # DELETE /messages/:id
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def ajax_update
    message = current_user.messages.friendly.find(params[:pk])
    pp message.self_and_descendants
    if message.update(params[:name] => params[:value])
      render json: {}, status: 200
    else
      render json: message.errors.full_messages.join(', '), status: 500
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_message
    @message = current_user.messages.friendly.find(params[:id])
  end

  def message_params
    {
        user: current_user,
        params: {
            to: params[:message][:to],
            cc: params[:message][:cc],
            from: "#{current_user.nickname}@smartsearch.email",
            subject: params[:message][:subject],
            body: params[:message][:body]
        }
    }
  end

  def response_params
    {
        user: current_user,
        origin: @message,
        params: {
            to: @message.to,
            from: "#{current_user.nickname}@smartsearch.email",
            subject: "Re: #{@message.subject}",
            body: params[:message][:body]
        }
    }
  end
end
