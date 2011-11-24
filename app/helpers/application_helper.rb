# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def short_nice_date(date)
    h date.strftime("%b %d, %Y")
  end          

end
