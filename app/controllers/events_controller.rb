class EventsController < ApplicationController
  
  def index
    @events = Event.published.order("id DESC")
    set_page_title "活動列表"
  end

  def show
    @event = Event.published.find(params[:id])
    @ticket_types = @event.ticket_types

    set_page_title @event.og_title

  end

end
