class Admin::RegistrationsController < AdminController

  def show
    @event = Event.find(params[:event_id])
    @registration = @event.registrations.find_by_token(params[:id])
  end

  def index
    @event = Event.find(params[:event_id])
    @registrations = @event.registrations.paid
    @registration_grid = initialize_grid(@registrations)
  end


  def all
    @event = Event.find(params[:event_id])
    @registrations = @event.registrations
    @registration_grid = initialize_grid(@registrations)
    render :index
  end

  def not_placed_not_expired

    @event = Event.find(params[:event_id])
    @registrations = @event.registrations.not_placed.not_expired
    @registration_grid = initialize_grid(@registrations)

    render :index
  end

  def not_placed_expired

    @event = Event.find(params[:event_id])
    @registrations = @event.registrations.not_placed.expired
    @registration_grid = initialize_grid(@registrations)

    render :index
  end


  def still_can_pay

    @event = Event.find(params[:event_id])
    @registrations = @event.registrations.still_can_pay
    @registration_grid = initialize_grid(@registrations)

    render :index
  end


  def cant_pay

    @event = Event.find(params[:event_id])
    @registrations = @event.registrations.cant_paid
    @registration_grid = initialize_grid(@registrations)

    render :index
  end

  def already_canceled

    @event = Event.find(params[:event_id])
    @registrations = @event.registrations.already_canceled
    @registration_grid = initialize_grid(@registrations)

    render :index

  end


end
