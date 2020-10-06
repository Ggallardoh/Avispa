class EventsController < ApplicationController
  before_action :set_event, only: [:view, :buy]

  # GET /events/:id
  def view
    if(@event.state == "published")
      render jsonapi: @event, fields: {events: [:name, :description, :start_date, :available_tickets, :price, :image]}
    else
      render json: {"errors": {"description":["Event does not exist or unavailable"]}}, status: :bad_request, content_type: "application/vnd.api+json"
    end
  end

  # GET /events
  def list
    @events = Event.where(state: "published").where("start_date < ?", (DateTime.now + 1.week)).where("start_date > ?", DateTime.now)
    render jsonapi: @events, fields: {events:[:id, :name, :start_date, :available_tickets, :price]}
  end

  # POST /event/:id/buy
  def buy
    if (@event.blank? || @event.state != "published")
      render json: {"errors": {"description":["Event does not exist or unavailable"]}}, status: :bad_request, content_type: "application/vnd.api+json"
    elsif @event.available_tickets < 1
      render json: {"errors": {"description":["Tickets sold out"]}}, status: :bad_request, content_type: "application/vnd.api+json"
    else
      @ticket = Ticket.new(ticket_params)
      @ticket.event_id = params[:id]

      loop do
        @ticket.confirmation_code = SecureRandom.alphanumeric(10)

        if Ticket.find_by(confirmation_code: @ticket.confirmation_code).nil?
          break
        end
      end

      if @ticket.save
        @event.update(:available_tickets => (@event.available_tickets - 1))
        render jsonapi: @ticket
      else
        render json: {"errors": @ticket.errors}, status: :bad_request, content_type: "application/vnd.api+json"
      end  
    end


  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def event_params
      params.require(:event).permit(:client_id, :name, :description, :image, :slug, :start_date, :publish_date, :state, :available_tickets, :price)
    end

    def ticket_params
      params.require(:data)
            .require(:attributes)
            .permit(:buyer_name, :buyer_email)
    end
end
