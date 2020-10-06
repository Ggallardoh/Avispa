class SerializableClient < JSONAPI::Serializable::Resource
    type 'clients'

    attributes :name
    
  end