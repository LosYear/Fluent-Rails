class PagesController < ApplicationController
  before_action :set_page, only: [:show]

  # GET /pages/1
  # GET /pages/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page
      @page = Page.friendly.find(params[:id])
    end
end
