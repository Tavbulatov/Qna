# frozen_string_literal: true

module VotesHelper
  def resource_name_and_id(resource)
    "#{resource.class.name}-#{resource.id}"
  end
end
