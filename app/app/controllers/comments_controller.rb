class CommentsController < ApplicationController
  API_URL = "https://jsonplaceholder.typicode.com"

  # GET /comments
  def index
    response = Faraday.get "#{API_URL}/comments" do |req|
      req.headers["User-Agent"] = "App Wapii Api."
      req.headers["cache-control"] = "no-cache"
      req.headers["Content-Type"] = "application/json"
    end

    json = parse_json(response.body)

    render json: { data: json, error: nil }, status: :ok
  end
end
