class LinksController < ApplicationController

  def destroy
    @link = Link.find(params[:id])
    if can? :destroy, @link

      @link.destroy
      flash[:notice] = 'Your link has been successfully deleted'
    end
  end
end
