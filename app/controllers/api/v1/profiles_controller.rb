# frozen_string_literal: true

module Api
  module V1
    class ProfilesController < Api::V1::BaseController
      authorize_resource class: User
      respond_to :json

      def me
        respond_with current_resource_owner
      end

      def all
        respond_with User.all.where.not(id: current_resource_owner.id)
      end
    end
  end
end
