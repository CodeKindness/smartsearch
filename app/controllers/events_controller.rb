class EventsController < ApplicationController
  before_action :set_company, only: [:update, :destroy]

  def create
    @event = current_user.events.new(event_params)

    if @event.save
      redirect_to env['HTTP_REFERER'], notice: 'Company was successfully created.'
    else
      redirect_to env['HTTP_REFERER'], notice: "Issue creating event: #{@event.error_messages}"
    end
  end

  def update
  end

  def destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_company
    @company = current_user.events.friendly.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    params.require(:event).permit(:event_type_id, :company_id, :contact_id, :start_at, :end_at, :description)
  end
end
