class CommentsController < ApplicationController

  # GET /posts
  def index

    response = Faraday.get 'https://jsonplaceholder.typicode.com/comments' do |req|
      req.headers['User-Agent'] = 'App Wapii Api.'
      req.headers['cache-control'] = 'no-cache'
      req.headers['Content-Type'] = 'application/json'

    end

    json = parse_json(response.body)

    render json: { data: json, error: nil }, status: :ok

  end

end
