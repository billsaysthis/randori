module ApplicationHelper
  def cash_available atm
    content_tag(:p, "Cash available at this ATM: " + number_to_currency(atm.balance), :class => 'bold')
  end
  
  def alert_display errs
    return unless errs.present?
    items = ""
    errs.each do |e|
      items += content_tag(:li, e)
    end
    ul = raw content_tag(:h2, "There was a problem with your withdrawal") + content_tag(:ul, raw(items))
    content_tag(:div, ul, {:id => "error_explanation"}, :escape => false)
  end
end
