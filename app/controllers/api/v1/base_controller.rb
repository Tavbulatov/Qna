# frozen_string_literal: true

module Api
  module V1
    class BaseController < ApplicationController
      before_action :doorkeeper_authorize!
      authorize_resource except: %i[me all]
      protect_from_forgery with: :null_session

      private

      def current_resource_owner
        @current_resource_owner ||= User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
      end

      alias current_user current_resource_owner
    end
  end
end
