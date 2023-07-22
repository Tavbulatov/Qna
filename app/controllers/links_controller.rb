class LinksController < ApplicationController
  def destroy
    @link = Link.find(params[:id])

    if @link.linkable.user?(current_user)
      @link.destroy
      flash[:notice] = 'Your link has been successfully deleted'
    else
      flash[:alert] = "You can't delete someone else's link"
    end
  end
end
