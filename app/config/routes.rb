Rails.application.routes.draw do

  get '/users' => 'users#index'
  get '/users//lists' => 'users#users_lists'
  get '/users/:id/posts' => 'users#users_posts'
  get '/posts' => 'posts#index'
  get '/posts/:id' => 'posts#show'
  get '/posts/:id/comments' => 'posts#show_comments'
  get '/comments' => 'comments#index'

  get '/trending/(:n)' => 'posts#trending'
  get '/influencers/(:n)' => 'users#influencers'

end
