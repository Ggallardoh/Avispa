class ClientsController < ApplicationController
  before_action :set_client, only: [:list]

  # GET /clients/:id/events
  def list
    @events = Event.select("'#{Event.model_name.plural}' as \"type\"", :id, :name, :start_date, :available_tickets, :price).where(client_id: params[:id])
    
    render json: {"data": @events}, content_type: "application/vnd.api+json"
  end

  # POST /client/:id/events
  def new
    @event = Event.new(event_params)

    @event.state = "created"
    @event.client_id = params[:id]
    @event.publish_date = DateTime.now

    if(@event.valid?)

      @event.slug = DateTime.parse(event_params[:start_date]).strftime('%Y-%m-%d')+"-"+event_params[:name].parameterize

      slug_counter = 0
      while Event.find_by(slug: @event.slug) do

        slug_counter += 1
        @event.slug += ("-"+slug_counter.to_s)
      
      end
    end

    if @event.save
      render json: @event, status: :created, location: @client, content_type: "application/vnd.api+json"
    else
      render json: {"errors": @event.errors}, status: :bad_request, content_type: "application/vnd.api+json"
    end
  end

  # POST /clients/:id/events/:event_id/publish
  def publish
    @event = Event.where(id: params[:event_id], client_id: params[:id])

    if @event.exists? && @event.update(state: "published")
      render json: @event, status: :accepted, location: @client, content_type: "application/vnd.api+json"
    else
      render json: {"errors": {"description":["Event does not exist"]}}, status: :bad_request, content_type: "application/vnd.api+json"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def client_params
      params.require(:client).permit(:name)
    end

    def event_params
      params.require(:data)
            .require(:attributes)
            .permit(:name, :start_date, :description, :image, :available_tickets, :price)
    end
end
