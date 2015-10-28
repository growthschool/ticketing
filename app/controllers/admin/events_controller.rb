class Admin::EventsController < AdminController
  layout "admin"

  before_action :authenticate_user!
  before_action :admin_required

  def index
    @events = Event.all
  end

  def new
    @event = Event.new
    session[:event_params] ||= {}
    @event.current_step = session[:event_step]


    set_page_title "建立活動"
  end

  def show
    @event = Event.find(params[:id])
    @registrations = @event.registrations
    @ticket_types = @event.ticket_types
    set_page_title " 活動主控台 for #{@event.name}"
  end

  def info

    @event = Event.find(params[:id])
    @registrations = @event.registrations
    @ticket_types = @event.ticket_types
    set_page_title " 基本資料 for #{@event.name}"

  end

  def edit
    @event = Event.find(params[:id])
     set_page_title " 管理活動 for #{@event.name}"
  end




  def create

    session[:event_params] ||= {}

    session[:event_params].deep_merge!(event_params) if params[:event]
    @event = Event.new(session[:event_params])
    @event.current_step = session[:event_step]
 



    if @event.valid?
      if params[:back_button]
        @event.previous_step
      elsif @event.last_step?
        @event.save if @event.all_valid?
      else
        @event.next_step
      end
   
      session[:event_step] = @event.current_step
    end

    if @event.new_record?
      render "new"
    else
      session[:event_step] = session[:event_params] = nil
      flash[:notice] = "成功建立活動"
      redirect_to admin_event_path(@event)
    end
  end

  def update
    @event = Event.find(params[:id])

    if @event.update(event_params)
      redirect_to admin_events_path
    else
      render :edit
    end
  end

  def publish
    @event = Event.find(params[:id])
    @event.publish!
    flash[:notice] = "已成功將活動上架"
    redirect_to :back
  end

  def draft
    @event = Event.find(params[:id])
    @event.make_draft!
    flash[:warning] = "已將活動下架"
    redirect_to :back
  end

  private

  def event_params
    params.require(:event).permit(:name, :description, 
      :seat_quantity, :location_name, :location_address,:human_started_at, :human_end_at,
      :ticket_types_attributes => [:_destroy,:name, :price, :amount, :allow_single_purchase_amount])
  end
end
