class Admin::BaseController < AdminController

  def index
    @events = Event.order("id DESC")

    set_page_title "綜覽"
  end
end
