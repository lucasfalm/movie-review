json.total_score @total_score

json.total_score_by_categories @total_score_by_categories do |score_by_category|
  json.category score_by_category[:category]
  json.total_score score_by_category[:total_score]
end
