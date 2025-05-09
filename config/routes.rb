Rails.application.routes.draw do
  resources :questions, only: [:index]
  root "home#index"
  get "/result", to: "questions#result"
  get "/analyzing", to: "questions#analyzing"
  get 'ogp/level:id', to: 'ogp#show', as: :ogp_level
end
