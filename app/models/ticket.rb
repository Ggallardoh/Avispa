class Ticket < ApplicationRecord
  belongs_to :event
  validates_presence_of :buyer_name, :buyer_email
end
