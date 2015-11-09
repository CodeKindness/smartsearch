class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  # GET /messages
  def index
    @messages = Message.with_inbox_state.order(originated_at: :desc)
  end

  # GET /messages/sent
  def sent
    @messages = Message.with_sent_state.order(originated_at: :desc)
    render :index
  end

  # GET /messages/spam
  def spam
    @messages = Message.with_spam_state.order(originated_at: :desc)
    render :index
  end

  # GET /messages/drafts
  def drafts
    @messages = Message.with_draft_state.order(originated_at: :desc)
    render :index
  end

  # GET /messages/trash
  def trash
    @messages = Message.with_trash_state.order(originated_at: :desc)
    render :index
  end

  # GET /messages/1
  def show
    @messages = Message.all
    @message.read!
  end

  # GET /messages/new
  def new
    @messages = Message.all
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  def create
    @message = SendMail.call(message_params)

    if @message.success?
      redirect_to messages_path, notice: "Message was successfully sent to #{@message.message.to}."
    else
      render :new
    end
  end

  # PATCH/PUT /messages/:id
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_message
    @message = Message.friendly.find(params[:id])
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
end
