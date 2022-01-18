class PostsController < ApplicationController

  API_URL = 'https://jsonplaceholder.typicode.com'

  # GET /posts
  def index

    response = Faraday.get "#{API_URL}/posts" do |req|
      req.headers['User-Agent'] = 'App Wapii Api.'
      req.headers['cache-control'] = 'no-cache'
      req.headers['Content-Type'] = 'application/json'

    end

    json = parse_json(response.body)

    render json: { data: json, error: nil }, status: :ok

  end

  # GET /posts
  def show

    response = Faraday.get "#{API_URL}/posts/#{params[:id]}" do |req|
      req.headers['User-Agent'] = 'App Wapii Api.'
      req.headers['cache-control'] = 'no-cache'
      req.headers['Content-Type'] = 'application/json'

    end

    json = parse_json(response.body)

    render json: { data: json, error: nil }, status: :ok

  end

  # GET/POST /posts/{id}/comments

  def show_comments
    response = Faraday.get "#{API_URL}/posts/#{params[:id]}/comments" do |req|
      req.headers['User-Agent'] = 'App Wapii Api.'
      req.headers['cache-control'] = 'no-cache'
      req.headers['Content-Type'] = 'application/json'

    end

    json = parse_json(response.body)

    render json: { data: json, error: nil }, status: :ok
  end

  def trending

    limit = params[:n].to_i || 5


    responsePosts = Faraday.get "#{API_URL}/posts" do |req|
      req.headers['User-Agent'] = 'App Wapii Api.'
      req.headers['cache-control'] = 'no-cache'
      req.headers['Content-Type'] = 'application/json'
    end

    posts = parse_json(responsePosts.body)

    postsComments = []

    posts.each do |post|

      responseComments = Faraday.get "#{API_URL}/comments?postId=#{post['id']}" do |req|
        req.headers['User-Agent'] = 'App Wapii Api.'
        req.headers['cache-control'] = 'no-cache'
        req.headers['Content-Type'] = 'application/json'
      end

      postComments = parse_json(responseComments.body)

      postsComments.push({
        postTitle: post['title'],
        postBody: post['body'],
        postUserId: post['userId'],
        postComments: postComments.length
      })

    end

    postsComments = postsComments.sort_by{|p| p[:postComments]}.take(limit)

    limitedPostsComments = []

    postsComments.each do |postComment|

      responseUser = Faraday.get "#{API_URL}/users/#{postComment[:postUserId]}" do |req|
        req.headers['User-Agent'] = 'App Wapii Api.'
        req.headers['cache-control'] = 'no-cache'
        req.headers['Content-Type'] = 'application/json'
      end

      user = parse_json(responseUser.body)

      limitedPostsComments.push({
        postUserName: user['name'],
        postTitle: postComment[:postTitle],
        postBody: postComment[:postBody],
        postComments: postComment.length
      })

    end

    render json: { limitedPostsComments: limitedPostsComments, error: nil }, status: :ok

  end

end
