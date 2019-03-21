Rails.application.routes.draw do
  root :to => 'search#movie'

  get 'search/people'
  get 'search/tv'
  get 'search/movie'

  get 'search/people/:id' => 'search#people_detail'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
