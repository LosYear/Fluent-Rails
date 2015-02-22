class NewsController < ApplicationController
  before_action :set_news, only: [:show]

  # GET /news/1
  # GET /news/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_news
      @news = News.friendly.find(params[:id])
    end
end
