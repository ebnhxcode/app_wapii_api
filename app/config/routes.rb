Rails.application.routes.draw do

  get '/users' => 'users#index'
  get '/posts' => 'posts#index'
  get '/posts/:id' => 'posts#show'
  get '/posts/:id/comments' => 'posts#show_comments'
  get '/comments' => 'comments#index'

  get '/trending/(:n)' => 'posts#trending'
  get '/influencers/:n' => 'users#influencers'



end
