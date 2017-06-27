json.array!(@activities) do |activity|
  json.extract! activity, :id, :title, :description
  json.start activity.start_date
  json.location activity.location
  json.end activity.end_date
  json.accessibility activity.accessibility
  json.hours activity.start_date.strftime("%H:%M")
  json.color activity.accessibility == "Private" ? "#000" : "blue"
  json.url activity.url

end
