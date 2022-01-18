class PostsController < ApplicationController


  # GET /posts
  def index

    response = Faraday.get 'https://jsonplaceholder.typicode.com/posts' do |req|
      req.headers['User-Agent'] = 'App Wapii Api.'
      req.headers['cache-control'] = 'no-cache'
      req.headers['Content-Type'] = 'application/json'

    end

    json = parse_json(response.body)

    render json: { data: json, error: nil }, status: :ok

  end

  # GET /posts
  def show

    response = Faraday.get "https://jsonplaceholder.typicode.com/posts/#{params[:id]}" do |req|
      req.headers['User-Agent'] = 'App Wapii Api.'
      req.headers['cache-control'] = 'no-cache'
      req.headers['Content-Type'] = 'application/json'

    end

    json = parse_json(response.body)

    render json: { data: json, error: nil }, status: :ok

  end

  # GET/POST /posts/{id}/comments

  def show_comments
    response = Faraday.get "https://jsonplaceholder.typicode.com/posts/#{params[:id]}/comments" do |req|
      req.headers['User-Agent'] = 'App Wapii Api.'
      req.headers['cache-control'] = 'no-cache'
      req.headers['Content-Type'] = 'application/json'

    end

    json = parse_json(response.body)

    render json: { data: json, error: nil }, status: :ok
  end

  def trending


    responsePosts = Faraday.get 'https://jsonplaceholder.typicode.com/posts' do |req|
      req.headers['User-Agent'] = 'App Wapii Api.'
      req.headers['cache-control'] = 'no-cache'
      req.headers['Content-Type'] = 'application/json'
    end

    posts = parse_json(responsePosts.body)

    postsComments = []

    posts.each do |post|

      responseComments = Faraday.get "https://jsonplaceholder.typicode.com/comments?postId=#{post['id']}" do |req|
        req.headers['User-Agent'] = 'App Wapii Api.'
        req.headers['cache-control'] = 'no-cache'
        req.headers['Content-Type'] = 'application/json'
      end

      postComments = parse_json(responseComments.body)
      #puts "https://jsonplaceholder.typicode.com/posts?userId=#{user['id']}"
      #puts userPosts
      #return

      #postsComments.push({userName: user['name'], userPosts: userPosts.length})
      postsComments.push(postComments)

    end

      render json: postsComments, status: :ok
      #puts user
      #return


  end

end
