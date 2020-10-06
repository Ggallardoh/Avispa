class SerializableTicket < JSONAPI::Serializable::Resource
    type 'tickets'

    attributes :event_id, :buyer_name, :buyer_email, :confirmation_code

    belongs_to :event
  end