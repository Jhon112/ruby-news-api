# News API Project
- This is a simple API built with Ruby on Rails that interacts with the GNews API for fetching articles. It also includes a caching mechanism to improve performance and reduce unnecessary API calls.

## Setup
1. Clone the repository

```bash
git clone "https://github.com/jhon112/ruby-news-api.git"
cd my-news-api
```

2. Install dependencies
```
bundle install
```

3. Environment variables
Create a .env file in the root directory of the project and add your GNews API key:

```
GNEWS_API_KEY=your_gnews_api_key
```

Replace your_gnews_api_key with your actual GNews API key.

Important: Do not commit the .env file to version control. It is already included in the .gitignore file.

4. Enable caching
In development, caching is disabled by default in Rails. Run the following command to enable it:

```
rails dev:cache
```
You should see the message Development mode is now being cached.

# Running the server
Start the Rails server:

```
rails s
```
Now you can access the API endpoints at http://localhost:3000.

# Running tests
To run the tests, use the following command:

```
bundle exec rspec
```

# Endpoints
  * Fetch N news articles: GET /articles?n=N
  * Find a news article with a specific title: GET /articles/search?title=TITLE
  * Search by keywords: GET /articles/search?keywords=KEYWORDS
  You can replace N, TITLE, and KEYWORDS with your desired values.

# Caching
This API service includes a caching mechanism using Rails' built-in caching. The cache is set to expire every 6 hours. Caching is important in this project to reduce the number of calls to the GNews API and to improve the response time of the API. Make sure caching is enabled in your environment (see step 4 in the Setup section).