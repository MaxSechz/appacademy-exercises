module ApplicationHelper
  def update_html
    "<input type=\"hidden\" name=\"_method\" value=\"patch\">".html_safe
  end
end
