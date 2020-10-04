class EventsController < ApplicationController
  before_action :set_event, only: [:show, :update, :destroy]

  # GET /events/:id
  def view
    @events = Event.all

    render json: {"response": "view"}
  end

  # GET /events
  def list
    render json: {"response": "list"}
    #render json: @event
  end

  # POST /event/:id/buy
  def buy
    @event = Event.new(event_params)

    render json: {"response": "buy"}
    # if @event.save
    #   render json: @event, status: :created, location: @event
    # else
    #   render json: @event.errors, status: :unprocessable_entity
    # end
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
end
