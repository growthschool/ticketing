module EventsHelper
  def render_event_publish_state(event)
    if event.is_displayed
      "已上架"
    else
      "未發布"
    end
  end

  def render_event_publish_option(event)
    if event.is_displayed
      link_to("下架", draft_admin_event_path(event), :method => :post )
    else
      link_to("上架", publish_admin_event_path(event), :method => :post )
    end
  end

  def render_event_location_info(event)

    location_name = event.location_name || "（未設定地點）"
    location_address = event.location_address || "（未設定地址）"

    return "#{location_name} / #{location_address}"
  end

  def render_event_hold_time(event)

    if event.started_at.present?
      started_at = event.started_at.strftime("%Y/%m/%d %H:%M:%S ")
      end_at = event.end_at.strftime("%Y/%m/%d %H:%M:%S ")

      "#{started_at} ~ #{end_at}"
    else
      ""
    end
  end
end
