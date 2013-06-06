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

  def get_day_symbol_for_int(dayInt)
    if dayInt == 0
      :monday
    elsif dayInt == 1
      :tuesday
    elsif dayInt == 2
      :wednesday
    elsif dayInt == 3
      :thursday
    elsif dayInt == 4
      :friday
    elsif dayInt == 5
      :saturday
    elsif dayInt == 6
      :sunday
    else
      :monday
    end
  end

end