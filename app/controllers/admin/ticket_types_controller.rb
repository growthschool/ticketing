class Admin::TicketTypesController < AdminController

  layout "admin"

  def index
    @event = Event.find(params[:event_id])
    @ticket_types = @event.ticket_types

    set_page_title "票種資訊 for #{@event.name}"
  end  
  def new
    @event = Event.find(params[:event_id])
    @ticket_type = @event.ticket_types.new
    set_page_title " 新增票種 for #{@event.name}"
  end


  def create
    @event = Event.find(params[:event_id])
    @ticket_type = @event.ticket_types.new(ticket_type_params)


    if @ticket_type.save
      redirect_to admin_events_path
    else
      render :new
    end
  end

  def edit
    @event = Event.find(params[:event_id])
    @ticket_type = @event.ticket_types.find(params[:id])
    set_page_title " 管理票種 : #{@ticket_type.name} for #{@event.name}"
  end

  def update

    @event = Event.find(params[:event_id])
    @ticket_type = @event.ticket_types.find(params[:id])

    if @ticket_type.update(ticket_type_params) 
      redirect_to admin_event_path(@event)   
    else
      render :edit
    end
  end

  private

  def ticket_type_params
    params.require(:ticket_type).permit(:name, :price, :amount, :allow_single_purchase_amount )
  end

end
