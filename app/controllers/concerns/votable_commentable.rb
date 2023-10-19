# frozen_string_literal: true

module VotableCommentable
  extend ActiveSupport::Concern

  def render_json(*data)
    respond_to do |format|
      format.json { render json: data }
    end
  end

  def set_resource(resource_name)
    resource_id = "#{params[resource_name].underscore}_id".to_sym
    @resource = params[resource_name].constantize.find(params[resource_id])
  end
end
