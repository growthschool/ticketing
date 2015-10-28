class Admin::TicketsController < AdminController

  def index

    @event = Event.find(params[:event_id])
    @tickets = @event.tickets.joins(:registration).merge(Registration.paid)
    @tickets_grid = initialize_grid(@tickets)
  end
end
