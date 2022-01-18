class UsersController < ApplicationController


  # GET /users
  def index

    responseUsers = Faraday.get 'https://jsonplaceholder.typicode.com/users' do |req|
      req.headers['User-Agent'] = 'App Wapii Api.'
      req.headers['cache-control'] = 'no-cache'
      req.headers['Content-Type'] = 'application/json'
    end

    users = parse_json(responseUsers.body)

    usersPosts = []

    users.each do |user|

      responsePosts = Faraday.get "https://jsonplaceholder.typicode.com/posts?userId=#{user['id']}" do |req|
        req.headers['User-Agent'] = 'App Wapii Api.'
        req.headers['cache-control'] = 'no-cache'
        req.headers['Content-Type'] = 'application/json'
      end

      userPosts = parse_json(responsePosts.body)
      #puts "https://jsonplaceholder.typicode.com/posts?userId=#{user['id']}"
      #puts userPosts
      #return

      usersPosts.push({userName: user['name'], userPosts: userPosts.length})


      #render json: { user: user, error: nil }, status: :ok
      #puts user
      #return

    end


    render json: { userPosts: usersPosts.sort_by{|p| p[:userPosts]}, error: nil }, status: :ok
    # render json: json, error: nil , status: :ok

  end


end
