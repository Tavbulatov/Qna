class SearchController < ApplicationController
  def search
    authorize! :search, :all

    unless search_params[:query].present?
      redirect_to root_path
    else
      @result = if search_params[:resource] == 'all'
                  ThinkingSphinx.search(search_params[:query])
                elsif search_params[:resource] == 'Answer'
                  Answer.search(search_params[:query])
                else
                  search_params[:resource].constantize.search(search_params[:query])
                end
    end
  end

  private
  def search_params
    params.permit(:query, :resource)
  end
end
