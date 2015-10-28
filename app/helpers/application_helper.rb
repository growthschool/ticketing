module ApplicationHelper
  def notice_message
    alert_types = { notice: :success, alert: :danger }

    close_button_options = { class: "close", "data-dismiss" => "alert", "aria-hidden" => true }
    close_button = content_tag(:button, "×", close_button_options)

    alerts = flash.map do |type, message|
      alert_content = close_button + message

      alert_type = alert_types[type.to_sym] || type
      alert_class = "alert alert-#{alert_type} alert-dismissable"

      content_tag(:div, alert_content, class: alert_class)
    end

    alerts.join("\n").html_safe
  end

  def ibutton(text, path, options = {})

    color_btn_class = ["btn-primary", "btn-danger", "btn-info" , "btn-warning", "btn-success", "btn-inverse"]

    class_name = (options[:class].present?)? options[:class] : ""
    icon_class = ""

    if options[:iclass].present?
      icon_class = options[:iclass]
      icon_class << " icon-white" if !(color_btn_class & class_name.split(" ")).empty?
      options.delete(:iclass)
    end
    link_to path, options do
      content_tag(:i, "", :class => icon_class) + content_tag(:span, " #{text}" )
    end
  end


  def render_cart_items_count(cart)
    cart.cart_items.count
  end
end
