class AdminController < ApplicationController

  layout "admin"

  before_action :authenticate_user!
  before_action :admin_required
 # before_action :set_page_title_for_admin


  def set_page_title_for_admin
    set_page_title "xxx"
  end

  helper_method :set_page_title


  # will also append current page number and the site name
  def set_page_title(title)
    if params[:page]
      @page_title = SeoHelper.format_current_page(title, params[:page])
    else
      @page_title = title
    end

    
    @page_title = SeoHelper.format_site_name( @page_title + " | Admin ", SeoHelper.configuration.site_name)
  end

end
