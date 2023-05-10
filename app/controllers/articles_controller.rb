class ArticlesController < ApplicationController
  def index
    number_of_articles = params[:n].to_i if params[:n].present?
    articles = fetch_news(number_of_articles)
    render json: articles
  end

  def search
    articles = fetch_news
    keyword = params[:keyword]
    title = params[:title]

    articles = articles.select { |article| article['title'].include?(title) } if title.present?
    articles = articles.select { |article| article['title'].include?(keyword) || article['description'].include?(keyword) } if keyword.present?

    render json: articles
  end

  private

  def fetch_news(number_of_articles = nil)
    begin
      cache_key = "articles"
      
      articles = Rails.cache.fetch(cache_key, expires_in: 6.hour) do
        conn = Faraday.new(url: 'https://gnews.io/api/v4/') do |faraday|
          faraday.response :json
          faraday.adapter Faraday.default_adapter
        end

        response = conn.get('top-headlines', { lang: 'en', apikey: ENV['GNEWS_API_KEY'] })
        response.body['articles']
      end

      articles = articles.first(number_of_articles) if number_of_articles.present?
      articles
    rescue
      articles = []
    end
  end
end
