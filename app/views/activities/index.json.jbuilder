json.activities @activities do |activity|


  json.extract! activity, :id, :title, :description
  json.start activity.date
  json.end activity.date
  json.url "#" #activity.url
end
