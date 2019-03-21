Rails.application.routes.draw do
  root :to => 'search#movie'

  get 'search/people'
  get 'search/tv'
  get 'search/movie'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
