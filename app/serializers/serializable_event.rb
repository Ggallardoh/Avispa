  class SerializableEvent < JSONAPI::Serializable::Resource
    type 'events'

    attributes :id, :name, :start_date, :available_tickets, :price, :description, :image, :slug, :publish_date, :state

    belongs_to :client
    
  end