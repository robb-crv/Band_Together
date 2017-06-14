json.notifications @notifications do |notification|

  json.etichetta notification.label
  json.is_read !notification.read_at.nil?
  json.created_at notification.created_at.strftime("%B %d, %Y at %H:%M")
  json.url notification.url
end
