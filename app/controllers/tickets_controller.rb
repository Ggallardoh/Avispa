class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :update, :destroy]
end
