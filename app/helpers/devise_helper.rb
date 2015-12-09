module DeviseHelper
  def devise_error_messages!
    return '' if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:p, msg, class:"text-danger text-center") }.join
    html = <<-HTML
    
    <div> #{messages}</div>
    HTML

    html.html_safe
  end
end