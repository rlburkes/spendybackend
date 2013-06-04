module ApplicationHelper
  def full_title(page_title)
    base_title = "Spendy"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end
  
  def pretty_money(amount)
    '$' + number_with_precision(amount, precision: 2) 
  end

end