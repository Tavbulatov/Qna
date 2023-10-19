# frozen_string_literal: true

json.extract! question, :id, :title, :body
json.author_id question.author.id
