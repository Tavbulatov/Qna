# frozen_string_literal: true

class AttachmentsController < ApplicationController
  before_action :authenticate_user!

  def destroy
    @attachment = ActiveStorage::Attachment.find(params[:id])
    @attachment.purge
    flash[:notice] = 'File deleted successfully'
  end
end
