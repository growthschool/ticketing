class RegistrationsController < ApplicationController

  before_action :find_registration,  :only => [:edit, :update, :show, :payinfo, :expired, :redo]
  before_action :check_expired, :only => [:edit, :update, :show, :payinfo]
  before_action :check_canceled, :only => [:edit, :update, :show, :payinfo]
  before_action :not_allow_blank_registration_info, :only => [:payinfo]
  before_action :not_allow_to_modify_registration_info, :only => [:edit]
  before_action :check_payment_status, :only => [:payinfo]

  # 請勿任意改動 before_filter 順序，此為有意義
  # 1. 先確認是否過期
  # 2. 沒有填寫報名資訊的，不可以去報名
  # 3. 已填寫報名資訊的，不可以更改報名資訊
  # 4. 付款的不能再去付錢

  def new
    @event = Event.published.find(params[:event_id])
    @registration = @event.registrations.new
    @ticket_types = @event.ticket_types

    set_page_title "選擇票種 for #{@event.og_title} "
  end

  def create

    @event = Event.published.find(params[:event_id])
    @registration = @event.registrations.new
    @ticket_types = @event.ticket_types

  


    if !(valid_registration && read_term )
      render :new
      return
    end
  
    if @registration.save(:validate => false)
      create_ticket_for_registration
      @registration.calculate_total!
      redirect_to edit_event_registration_path(@event, @registration.token)
    else
      render :new
    end

  end

  def read_term
    if params[:registration][:human_agree_term].present? && params[:registration][:human_agree_term].to_i > 0
      return true      
    else
      flash[:danger] = "請確認已同意 隱私權政策 "
      return false
    end
  end

  def expired
    render :text => "此張票已過期"
  end

  def canceled
    render :text => "此張票已取消"
  end

  def show
    @tickets = @registration.tickets
    set_page_title "票卷資訊 #{@registration.token} "    
  end

  def payinfo
    @tickets = @registration.tickets

    set_page_title "選擇付款方式 for #{@event.og_title} "    
  end

  def update

    @tickets = @registration.tickets

    if @registration.update(registration_params)
      
      @registration.extend_expired_time! # 延長一小時繳費

      redirect_to payinfo_event_registration_path(@event, @registration.token)
    else
      render :edit
    end
  end

  def edit

    @tickets = @registration.tickets
    @ticket_types = @event.ticket_types

    set_page_title "填選購買資訊 for #{@event.og_title} "    
  end

  def create_ticket_for_registration
    ticket_hash = params[:tickets]
    ticket_hash.each_key do |key|
      ticket_hash[key].to_i.times do 
        ticket = @registration.tickets.build
        ticket.event_id = @registration.event_id
        ticket_type = TicketType.find(key)
        ticket.ticket_type = ticket_type
        ticket.price = ticket_type.price
        ticket.save(:validate => false)
      end
    end
  end

  def valid_registration
    flag = true
    ticket_hash = params[:tickets]
    total_amount = 0
    ticket_hash.each_key do |key|
      purchase_amount = ticket_hash[key].to_i
      total_amount = total_amount + purchase_amount
      ticket_type = TicketType.find(key)
      # amount.nil 是無限的意思
      if ticket_type.available_amount.present? && purchase_amount > ticket_type.available_amount.to_i
        flash[:danger] = "#{ticket_type.name} 數量不足以完成此次販售"
        flag = false
        break
      end
    end

    if total_amount > @event.available_seat
      flash[:danger] = "剩餘票卷數量不足以完成此次販售"
      flag = false
    end

    if total_amount == 0
      flash[:danger] = "你至少需要選擇一張票"
      flag = false
    end

    Rails.logger.info "XXXX : #{flag}"
    return flag
  end

  def redo

    @registration.cancel!
    redirect_to new_event_registration_path(@event)
  end

  protected

  def find_registration

    @event = Event.published.find(params[:event_id])
    @registration = @event.registrations.find_by_token(params[:id])

  end

  def check_expired
    if @registration.expired?
      redirect_to expired_event_registration_path(@event, @registration.token)
      return
    end
  end

  def check_canceled

    if @registration.is_canceled?
      redirect_to canceled_event_registration_path(@event, @registration.token)
      return
    end

  end

  def not_allow_blank_registration_info
    if !@registration.filled_info?
      flash[:danger] = "請先填寫購票者資訊"
      redirect_to edit_event_registration_path(@event, @registration.token)
      return
    end
  end


  def not_allow_to_modify_registration_info
    if @registration.filled_info?
      flash[:danger] = "不能再更改購買者資訊，轉讓請聯絡 hello@growth.school"
      redirect_to event_registration_path(@event, @registration.token)
      return
    end
  end

  def check_payment_status
    if @registration.is_paid?
      redirect_to event_registration_path(@event, @registration.token)
      return
    end
  end



  private

  def registration_params
    params.require(:registration).permit( :name, :email, :cell_phone, :tickets_attributes => [:id, :name,
      :email, :cell_phone])
  end
end
