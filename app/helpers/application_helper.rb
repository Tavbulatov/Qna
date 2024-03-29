# frozen_string_literal: true

module ApplicationHelper
  def flash_message_css_class(key)
    case key.to_sym
    when :notice then 'alert alert-info'
    when :success then 'alert alert-success'
    when :error then 'alert alert-error'
    when :alert then 'alert alert-danger'
    end
  end
end
