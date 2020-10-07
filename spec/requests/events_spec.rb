require 'rails_helper'

RSpec.describe "buys ticket" do
    fixtures :all
    before do 
        post '/event/1/buy', :params => 
        {
            "data": 
            {
                "type": "ticket",
                "attributes": 
                {
                    "buyer_name": "German",
                    "buyer_email": "comprador@mail.com"
                }
            }
        }

          post '/event/1/buy', :params => 
        {
            "data": 
            {
                "type": "ticket",
                "attributes": 
                {
                    "buyer_name": "Ignacio",
                    "buyer_email": "comprador@mail.com"
                }
            }
        }
    end
    it "lowers available tickets for the event" do 
        expect(Event.find(1).available_tickets).to eq(70)
    end
    it "returns valid code" do 
        code = JSON.parse(response.body)['data']['attributes']['confirmation_code']

        expect(code.length).to be_between(6, 10).inclusive

        first_ticket_code = Ticket.find_by(buyer_name: "German").confirmation_code
        second_ticket_code = Ticket.find_by(buyer_name: "Ignacio").confirmation_code

        expect(first_ticket_code.next).not_to eq(second_ticket_code)

    end
end