class LinksController < ApplicationController

  def destroy
    @link = Link.find(params[:id])
    authorize! :destroy, @link

    @link.destroy
    flash[:notice] = 'Your link has been successfully deleted'
  end
end
