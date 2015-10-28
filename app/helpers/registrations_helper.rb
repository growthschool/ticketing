module RegistrationsHelper

  def render_registration_state(r)
    state_str = ""
    if r.is_paid?
      state_str = "已付款"
    else
      if r.expired_at.present? 
        if r.expired_at < Time.now
          state_str = "未結帳(未過期)"
        else
          state_str = "未結帳(未過期)"
        end
      else
        if r.should_paid_at.present? 
          if r.should_paid_at < Time.now
            state_str = "應結帳(未過期）"
          else
            state_str = "應結帳(已過期）"
          end
        end
      end

    end

    if r.is_canceled?
      state_str = "已取消"
    end

    return state_str
  end


  def render_registration_temp_expired_at(registration) 
    if registration.expired_at.present?
      registration.expired_at.strftime("%Y/%m/%d %H:%M:%S ")
    elsif registration.should_paid_at.present?
      registration.should_paid_at.strftime("%Y/%m/%d %H:%M:%S ")
    end
        
  end
end
