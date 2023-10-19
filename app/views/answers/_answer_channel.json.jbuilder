# frozen_string_literal: true

json.extract! answer, :id, :body
author_id = answer.author.id

json.author_id author_id
json.rating answer.rating
json.authenticity_token authenticity_token

json.links answer.links.each do |link|
  json.id link.id
  json.name link.name
  json.url link.url
  json.author_id author_id
end

json.files answer.files.each do |file|
  json.id file.id
  json.name file.filename.to_s
  json.url file.url
  json.author_id author_id
end
