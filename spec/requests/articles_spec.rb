require 'rails_helper'

RSpec.describe "Articles", type: :request do
  before do
    stub_request(:get, "https://gnews.io/api/v4/top-headlines?lang=en&token")
    .with(
      headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'User-Agent'=>'Faraday v1.10.3'
      }
    )
    .to_return(status: 200, body: { 'articles': [
      { 'title': 'Test title', 'author': 'Test author', 'description': 'Test description' },
      { 'title': 'Test title 2', 'author': 'Test author 2', 'description': 'Test description 2' }
    ] }.to_json, headers: {})
  end

  describe "GET /index" do
    it "returns a successful response" do
      get '/articles'
      expect(response).to have_http_status(:success)
    end

    it "returns a specific number of articles" do
      get '/articles', params: { n: 1 }
      json = JSON.parse(response.body)
      expect(json.length).to eq(1)
    end
  end

  describe "GET /search" do
    it "returns a successful response" do
      get '/articles/search', params: { title: 'Test' }
      expect(response).to have_http_status(:success)
    end

    it "returns articles with a matching title" do
      get '/articles/search', params: { title: 'Test' }
      json = JSON.parse(response.body)
      json.each do |article|
        expect(article['title']).to include('Test')
      end
    end

    it "returns articles with a matching author" do
      get '/articles/search', params: { author: 'Test' }
      json = JSON.parse(response.body)
      json.each do |article|
        expect(article['author']).to include('Test')
      end
    end

    it "returns articles with a matching keyword in title or description" do
      get '/articles/search', params: { keyword: 'Test' }
      json = JSON.parse(response.body)
      json.each do |article|
        expect(json[0]['title']).to include('Test')
        expect(json[0]['description']).to include('Test')
      end
    end
  end
end
