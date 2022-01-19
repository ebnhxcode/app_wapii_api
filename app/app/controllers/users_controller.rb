class UsersController < ApplicationController
  API_URL = "https://jsonplaceholder.typicode.com"

  # GET /users
  def index
    responseUsers = Faraday.get "#{API_URL}/users" do |req|
      req.headers["User-Agent"] = "App Wapii Api."
      req.headers["cache-control"] = "no-cache"
      req.headers["Content-Type"] = "application/json"
    end

    users = parse_json(responseUsers.body)

    usersPosts = []

    users.each do |user|
      responsePosts = Faraday.get "#{API_URL}/posts?userId=#{user["id"]}" do |req|
        req.headers["User-Agent"] = "App Wapii Api."
        req.headers["cache-control"] = "no-cache"
        req.headers["Content-Type"] = "application/json"
      end

      userPosts = parse_json(responsePosts.body)
      #puts "#{API_URL}/posts?userId=#{user['id']}"
      #puts userPosts
      #return

      usersPosts.push({ userName: user["name"], userPosts: userPosts.length })

      #render json: { user: user, error: nil }, status: :ok
      #puts user
      #return

    end

    render json: { userPosts: usersPosts.sort_by { |p| p[:userPosts] }, error: nil }, status: :ok
    # render json: json, error: nil , status: :ok

  end

  # GET /influencers/{n}
  def influencers
    limit = params[:n].to_i || 5
    if limit == 0
      limit = 5
    end

    # Puede que un usuario no tenga posts
    responsePosts = Faraday.get "#{API_URL}/posts" do |req|
      req.headers["User-Agent"] = "App Wapii Api."
      req.headers["cache-control"] = "no-cache"
      req.headers["Content-Type"] = "application/json"
    end

    postsUserIds = parse_json(responsePosts.body).pluck("userId").uniq

    usersPosts = []

    postsUserIds.each do |userId|
      responeUserPosts = Faraday.get "#{API_URL}/posts?userId=#{userId}" do |req|
        req.headers["User-Agent"] = "App Wapii Api."
        req.headers["cache-control"] = "no-cache"
        req.headers["Content-Type"] = "application/json"
      end

      userPosts = parse_json(responeUserPosts.body)

      usersPosts.push(userPosts)
    end

    usersPosts = usersPosts.flatten.uniq

    postsComments = []

    usersPosts.each do |post|
      responsePostsComments = Faraday.get "#{API_URL}/comments?postId=#{post["id"]}" do |req|
        req.headers["User-Agent"] = "App Wapii Api."
        req.headers["cache-control"] = "no-cache"
        req.headers["Content-Type"] = "application/json"
      end

      postComments = parse_json(responsePostsComments.body)

      postsComments.push({
        userId: post["userId"],
        postId: post["id"],
        comments: postComments.length,
      })
    end

    popularity = []

    postsUserIds.each do |userId|
      responseUser = Faraday.get "#{API_URL}/users/#{userId}" do |req|
        req.headers["User-Agent"] = "App Wapii Api."
        req.headers["cache-control"] = "no-cache"
        req.headers["Content-Type"] = "application/json"
      end

      user = parse_json(responseUser.body)

      userComments = postsComments.select { |h| h[:userId] == userId }.map { |h| h[:comments] }.reduce(:+)

      popularity.push({
        userId: userId,
        userName: user["name"],
        commentsCount: userComments,
      })
    end

    totalComments = popularity.map { |s| s[:commentsCount] }.reduce(0, :+)

    popularity.each do |user|
      userComments = user[:commentsCount]
      percentageOfPopularity = (userComments * 100) / totalComments
      user[:percentageOfPopularity] = percentageOfPopularity
    end

    render json: { data: popularity.sort_by { |p| p[:percentageOfPopularity] }.take(limit), error: nil }, status: :ok
  end
end
