class OrdersController < ApplicationController
 
  protect_from_forgery except: [:pay2go_atm_code, :pay2go_cc_notify, :pay2go_atm_complete ]

  def show
    @order = Registration.find_by_token(params[:id])
  end

  def complete
    @order = Registration.find_by_token(params[:id])
  end

  def pay2go_cc_notify
    @order = Registration.find_by_token(params[:id])

    if params["Status"] == "SUCCESS"
      return_result = JSON.parse(params["Result"])

      log = @order.trade_logs.build
      log.content = return_result
      log.save

      @order.pay!
      # TODO : add CheckCode

      if @order.is_paid?
        flash[:notice] = "信用卡付款成功"
        redirect_to event_registration_path(@order.event, @order.token)
      else
        render text: "信用卡失敗"
      end
    else
      render text: "交易失敗"
    end
  end

  def pay2go_atm_code
    @order = Registration.find_by_token(params[:id])

    json_data = JSON.parse(params["JSONData"])

    if json_data["Status"] == "SUCCESS"

      return_result = JSON.parse(json_data["Result"])

      log = @order.trade_logs.build
      log.content = return_result
      log.save


      @order.set_payment_with!("atm")
      @order.bank_code = return_result["BankCode"]
      @order.bank_no = return_result["CodeNo"]
      @order.should_paid_at = DateTime.parse(return_result["ExpireDate"]) - 1.minutes
      @order.save

      redirect_to payinfo_event_registration_path(@order.event, @order.token)
    else
      render text: "產生 ATM 帳號失敗"
    end
  end

  def pay2go_atm_complete
    @order = Registration.find_by_token(params[:id])

    json_data = JSON.parse(params["JSONData"])

    if json_data["Status"] == "SUCCESS"

      return_result = JSON.parse(json_data["Result"])

      log = @order.trade_logs.build
      log.content = return_result
      log.save


      paid_time = return_result["PayTime"]

      @order.pay!(DateTime.parse(paid_time))
      @order.save

      redirect_to event_registration_path(@order.event, @order.token)
    else
      render text: "產生 ATM 帳號失敗"
    end    

  end



  private

  def order_params
    params.require(:order).permit(info_attributes: [:billing_name,
                                                    :billing_address,
                                                    :shipping_name,
                                                    :shipping_address] )
  end
end
