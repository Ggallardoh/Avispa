class Event < ApplicationRecord
  belongs_to :client
  validates_presence_of :name, :start_date, :description, :image, :available_tickets, :price
end
